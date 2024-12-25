#import "@preview/fletcher:0.5.3"
#import "algorithms.typ"
#import "styling.typ": styling

#let default-styling = (
	spread: 7em, 
	grow: 4.5em,
	shape: fletcher.shapes.rect,
	inset: 0.6em,
	fill: white,
	stroke: 0.5pt, 
	radius: 2pt, 
	text: black,
	arrow-tip: "-|>",
	arrow-stroke: 0.5pt,
	alignment: center,
	algorithm: algorithms.centered-tree
)

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
	styling: styling(),
	origin: (0cm, 0cm),
	body
) = {

	// Every child of the primary node is a different tree
	let tree-styling = default-styling + styling
	for tree in content-to-tree(body).children {
		fletcher.diagram({
			tree-styling.at("algorithm")(tree, origin, tree-styling)
		})
	}

}