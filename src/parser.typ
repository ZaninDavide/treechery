// Turns the bullet-list content into a dictionary
#let parse-bullet-list(body) = {
	let parse-with-id(body, id, depth) = {
		if body.has("children") == false or body.children.len() == 0 { 
			return (
				content: body, 
				height: 0, 
				depth: depth, 
				leaves: 1, 
				children: (),
				id: id,
			)
		}

		let content = [] // content of the node 
		let children = () // children of this node

		let head = true
		let leaves = 0
		let height = 0
		for child in body.children {
			if child.func() == list.item {
				head = false
				let subtree = parse-with-id(child.body, id, depth + 1)
				id = subtree.id + 1 
				leaves += subtree.leaves
				if height <= subtree.height { height = subtree.height + 1 }
				children.push(subtree)
			} else if head {
				content += child
			}
		}

		return (
			content: content, 
			children: children,
			depth: depth, // How deep is this node in the tree
			height: height, // How deep is the deepest child in this tree
			leaves: calc.max(1, leaves), // How many leaves does this node have
			id: id, // A unique id for this node
		)
	}

	return parse-with-id(body, 0, 0)
}

// Turns the numbered-list content into a dictionary
#let parse-numbered-list(body) = { 
  // TODO 
}

// Turns the term-list content into a dictionary
#let parse-term-list(body) = { 
  // TODO 
}
