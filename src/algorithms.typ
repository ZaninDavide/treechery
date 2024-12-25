#import "@preview/fletcher:0.5.3"
#import "styling.typ": node-styling, styling-to-make-functions

// Draw tree such that the parent is always centered
#let even-children(tree, origin, tree-styling) = {	
	let res = []

	// Parent
	let parent-styling = node-styling(tree.content, tree-styling)
	res += styling-to-make-functions(parent-styling).at("make-node")(origin, tree.content)

	// Children
	let max-child-width = tree.children.fold(0, (acc, cur) => { return calc.max(acc, cur.width) })
	let cur = (
    origin.at(0) - (max-child-width * (tree.children.len() - 1)) * parent-styling.spread / 2, 
    origin.at(1) - parent-styling.grow
  )
	for subtree in tree.children {
    // Draw subtree
		let this-styling = node-styling(subtree.content, tree-styling)
		res += styling-to-make-functions(this-styling).at("make-edge")(origin, cur)
		res += this-styling.at("algorithm")(subtree, cur, tree-styling)
    // Increment position
		cur = (cur.at(0) + max-child-width * parent-styling.spread, cur.at(1))
	}

	return res
}

// Draw tree such that the first child is always straight below it's parent
#let centered-firstborn(tree, origin, tree-styling) = {
	let res = []

	// Parent
	let parent-styling = node-styling(tree.content, tree-styling)
	res += styling-to-make-functions(parent-styling).at("make-node")(origin, tree.content)

	// Children
	let cur = (origin.at(0), origin.at(1) - parent-styling.grow)
	for subtree in tree.children {
    // Draw subtree
		let this-styling = node-styling(subtree.content, tree-styling)
		res += styling-to-make-functions(this-styling).at("make-edge")(origin, cur)
		res += this-styling.at("algorithm")(subtree, cur, tree-styling)
    // Increment position
		cur = (cur.at(0) + subtree.width * parent-styling.spread, cur.at(1))
	}
	return res
}

// Draw tree such that the subtree under every parent is centered with respect to it
#let centered-tree(tree, origin, tree-styling) = {
	let res = []

	// Parent
	let parent-styling = node-styling(tree.content, tree-styling)
	res += styling-to-make-functions(parent-styling).at("make-node")(origin, tree.content)

	// Children
	let first_child_width = tree.children.at(0, default: (width: 0)).width
	let last_child_width = tree.children.at(-1, default: (width: 0)).width
	let cur = (
    origin.at(0) - (tree.width - first_child_width/2.0 - last_child_width/2.0) * parent-styling.spread / 2, 
    origin.at(1) - parent-styling.grow
  )
	for (index, subtree) in tree.children.enumerate() {
		// Draw subtree
		let this-styling = node-styling(subtree.content, tree-styling)
		res += styling-to-make-functions(this-styling).at("make-edge")(origin, cur)
		res += this-styling.at("algorithm")(subtree, cur, tree-styling)
  	// Increment position
		let next_subtree_width = tree.children.at(index + 1, default: (width: 0)).width
		cur = (cur.at(0) + (subtree.width + next_subtree_width) * parent-styling.spread / 2, cur.at(1))
	}
	
	return res
}