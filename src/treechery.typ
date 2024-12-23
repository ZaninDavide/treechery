#import "@preview/fletcher:0.5.3"
#import "algorithms.typ"

#let styling(
	shape: fletcher.shapes.rect,
	inset: 7pt, 
	fill: white,
	stroke: 0.5pt, 
	radius: 2pt, 
	text: black,
	arrow-tip: "-|>",
	arrow-stroke: 0.5pt,
	alignment: center 
) = {
	return (
		make-node: (origin, content) => fletcher.node(
			origin, 
			inset: inset, 
			corner-radius: radius, 
			shape: shape, 
			stroke: stroke, 
			fill: fill, {
				set std.text(fill: text)
				align(center, content)
			}
		),
		make-edge: (from, to) => fletcher.edge(from, arrow-tip, to, stroke: arrow-stroke),
	)
}

#let decorator(styling) = {
	return metadata((owner: "treechery", styling: styling))
}

#let content-to-tree(body) = {
	if body.has("children") == false or body.children.len() == 0 { 
		return (
			content: body, 
			depth: 0, 
			width: 1, 
			children: (),
		)
	}

	let content = [] // content of the node 
	let children = () // children of this node

	let head = true
	let width = 0
	let depth = 0
	for child in body.children {
		if child.func() == list.item {
			head = false
			let child = content-to-tree(child.body)
			width += child.width
			if depth <= child.depth { depth = child.depth + 1 }
			children.push(child)
		} else if head {
			content += child
		}
	}

	return (
		content: content, 
		depth: depth, 
		width: calc.max(1, width), 
		children: children
	)
}

#let tree(
	spread: 2.75cm, 
	grow: 1.75cm,
	styling: styling(),
	algorithm: algorithms.centered-children,
	body
) = {

	// Every child of the primary node is a different tree
	for tree in content-to-tree(body).children {
		fletcher.diagram({
			algorithm(tree, (0cm, 0cm), spread, grow, styling)
		})
	}

}