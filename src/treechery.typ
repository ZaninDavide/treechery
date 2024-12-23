#import "@preview/cetz:0.3.1"

#let custom_node(boxer) = {
	return metadata((
		type: "treechery",
		boxer: boxer,
	))
}

#let node(
	stroke: 0.5pt, 
	radius: 2pt, 
	inset: 7pt, 
	fill: gray.lighten(80%),
	text: black,
	alignment: center 
) = {
	return custom_node(content => box(
		stroke: stroke, 
		radius: radius, 
		inset: inset, 
		fill: fill, {
			set std.text(fill: text);
			align(alignment, content)
		}
	))
}

#let content_to_tree(body) = {
	if body.has("children") == false { 
		return body
	}

	let content = [] // content of the node 
	let items = () // children of this node

	let head = true
	for child in body.children {
		if child.func() == list.item {
			head = false
			items.push(content_to_tree(child.body))
		} else if head {
			content += child
		}
	}

	return (content, ..items)
}

#let treechery(
	boxer: node().value.boxer,
	stroke: 0.5pt, 
	spread: 2.75, 
	grow: 1.75,
	direction: "down",
	body
) = {
	let data = content_to_tree(body);
	data.remove(0);

	let draw-node = (node, ..) => {
		let element = boxer(node.content)
		let found = false
		if repr(node.content.func()) == "sequence" {
			// Find metadata for styling 
			for child in node.content.children {
				if child.func() == metadata and child.value.type == "treechery" {
					if type(child.value.boxer) == function {
						element = (child.value.boxer)(node.content)
					}
					found = true
					break;
				}
			}
		}
    cetz.draw.content((), element)
  }

	let draw-edge = (from, to, ..) => {
    cetz.draw.line(
			(a: from, number: 0, b: to),
      (a: to, number: 0, b: from), 
			// mark: (end: ">"),
			stroke: stroke,
		)
  }

	return align(center)[#{
		for data-tree in data {
			cetz.canvas({
				// Draw edges
				cetz.tree.tree(
						data-tree,
						draw-node: (node, ..) => {},
						draw-edge: draw-edge,
						spread: spread, 
						grow: grow,
						direction: direction,
				)
				// Draw nodes
				cetz.tree.tree(
						data-tree,
						draw-node: draw-node,
						draw-edge: (from, to, ..) => {},
						spread: spread, 
						grow: grow,
						direction: direction,
				)
			})
		}
	}]
}