// Draw tree such that the subtree under every parent is centered with respect to its children
#let default(tree) = {
	let process-tree(tree, left-leaves) = {
		if tree.children.len() == 0 {
			// Leaf node
			(
				x: left-leaves, 
				y: -tree.depth, 
				children: tree.children, 
				content: tree.content, 
				left-leaves: left-leaves + 1
			)
		} else {
			let updated-children = ()
			for child in tree.children { 
				// Children
				let updated-child = process-tree(child, left-leaves)
				updated-children.push(updated-child)
				left-leaves = updated-child.left-leaves 
			}
			// Parent node
			(
				x: updated-children.fold(0, (acc, child) => {acc + child.x}) / updated-children.len(),
				y: -tree.depth,
				children: updated-children,
				content: tree.content,
				left-leaves: left-leaves
			)
		}
	}
	return process-tree(tree,0)
}

// Draw tree such that the first child is always straight below it's parent
#let waterfall(tree) = {
	let process-tree(tree, left-leaves) = {
		if tree.children.len() == 0 {
			// Leaf node
			(
				x: left-leaves, 
				y: -tree.depth, 
				children: tree.children, 
				content: tree.content, 
				left-leaves: left-leaves + 1
			)
		} else {
			let updated-children = ()
			for child in tree.children { 
				// Children
				let updated-child = process-tree(child, left-leaves)
				updated-children.push(updated-child)
				left-leaves = updated-child.left-leaves 
			}
			// Parent node
			(
				x: updated-children.first().x,
				y: -tree.depth,
				children: updated-children,
				content: tree.content,
				left-leaves: left-leaves
			)
		}
	}
	return process-tree(tree,0)
}