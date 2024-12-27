#import "@preview/fletcher:0.5.3"
#import "../styling.typ": styling, node-styling
#import "../parser.typ": parse-bullet-list
#import "algorithms.typ"

#let draw-node(origin, content, styling) = {
	return fletcher.node(
		origin, 
		inset: styling.at("inset"), 
		corner-radius: styling.at("radius"), 
		shape: styling.at("shape"), 
		stroke: styling.at("stroke"), 
		fill: styling.at("fill"), 
		{
			set std.text(fill: styling.at("text"))
			align(center, content)
		}
	)
}

#let draw-arrow(from, to, styling) = {
	return fletcher.edge(
		from, 
		styling.at("arrow-tip"), 
		to, 
		stroke: styling.at("arrow-stroke")
	)
}

// Draw a tree of the form (x: length, y: length, content: content, children: (...))
#let draw-tree(tree, spread, grow, origin, tree-styling) = {
	let res = []
	// Draw parent
	res += draw-node(
		(tree.x * spread, tree.y * grow), 
		tree.content, 
		node-styling(tree.content, tree-styling)
	)
	for subtree in tree.children {
		// Draw subtree
		res += draw-arrow(
			(origin.at(0) + tree.x * spread, origin.at(1) + tree.y * grow), 
			(origin.at(0) + subtree.x * spread, origin.at(1) + subtree.y * grow),
			node-styling(subtree.content, tree-styling)
		)
		res += draw-tree(subtree, spread, grow, origin, tree-styling)
	}
	return res
}

#let tree(
	styling: styling(),
	spread: 7em, 
	grow: 4.5em,
	algorithm: algorithms.default,
	body
) = {
	let default-tree-styling = (
		shape: fletcher.shapes.rect,
		inset: 0.6em,
		fill: white,
		stroke: 0.5pt, 
		radius: 2pt, 
		text: black,
		arrow-tip: "-|>",
		arrow-stroke: 0.5pt,
		alignment: center,
	)
	// Every child of the primary node is a different tree
	let tree-styling = default-tree-styling + styling
	for tree in parse-bullet-list(body).children {
		fletcher.diagram({
			draw-tree(algorithm(tree), spread, grow, (0cm, 0cm), tree-styling)
		})
	}

}