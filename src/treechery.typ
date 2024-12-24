#import "@preview/fletcher:0.5.3"
#import "algorithms.typ"
#import "styling.typ": styling

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
	algorithm: algorithms.centered-children,
	origin: (0cm, 0cm),
	body
) = {

	// Every child of the primary node is a different tree
	for tree in content-to-tree(body).children {
		fletcher.diagram({
			algorithm(tree, origin, styling)
		})
	}

}