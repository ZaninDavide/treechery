#import "@preview/fletcher:0.5.3"

#let node-styling(tree, default-styling) = {
  let is-decorator(obj) = (
    obj.func() == metadata and 
    obj.value.at("owner", default: none) == "treechery" and 
    obj.value.at("styling", default: none) != none 
  )

  if is-decorator(tree.content) { return tree.content.value.styling } 
  
  let styling = default-styling
  if repr(tree.content.func()) == "sequence" {
    for obj in tree.content.children {
      if is-decorator(obj) {
        styling += obj.value.styling
      }
    }
  }

  return styling
}

// Draw tree such that the parent is always centered
#let centered-children(tree, origin, spread, grow, default-styling) = {	
	let res = []

	// Parent
	res += node-styling(tree, default-styling).at("make-node")(origin, tree.content)

	// Children
	let max-child-width = tree.children.fold(0, (acc, cur) => { return calc.max(acc, cur.width) })
	let cur = (
    origin.at(0) - (max-child-width * (tree.children.len() - 1)) * spread / 2, 
    origin.at(1) - grow
  )
	for subtree in tree.children {
    // Draw subtree
		res += node-styling(subtree, default-styling).at("make-edge")(origin, cur)
		res += centered-children(subtree, cur, spread, grow, default-styling)
    // Increment position
		cur = (cur.at(0) + max-child-width * spread, cur.at(1))
	}

	return res
}

// Draw tree such that the first child is always below it's parent
#let centered-firstborn(tree, origin, spread, grow, default-styling) = {
	let res = []

	// Parent
	res += node-styling(tree, default-styling).at("make-node")(origin, tree.content)

	// Children
	let cur = (origin.at(0), origin.at(1) - grow)
	for subtree in tree.children {
    // Draw subtree
		res += node-styling(subtree, default-styling).at("make-edge")(origin, cur)
		res += centered-firstborn(subtree, cur, spread, grow, default-styling)
    // Increment position
		cur = (cur.at(0) + subtree.width * spread, cur.at(1))
	}
	return res
}