#import "@preview/fletcher:0.5.3"

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
)

#let styling(
	spread: auto, 
	grow: auto,
	shape: auto,
	inset: auto,
	fill: auto,
	stroke: auto, 
	radius: auto, 
	text: auto,
	arrow-tip: auto,
	arrow-stroke: auto,
	alignment: auto,
	make-node: auto,
	make-edge: auto,
) = {
	let dict = (:)

	if spread != auto { dict.insert("spread", spread) }
	if grow != auto { dict.insert("grow", grow) }
	if shape != auto { dict.insert("shape", shape) }
	if inset != auto { dict.insert("inset", inset) }
	if fill != auto { dict.insert("fill", fill) }
	if stroke != auto { dict.insert("stroke", stroke) }
	if radius != auto { dict.insert("radius", radius) }
	if text != auto { dict.insert("text", text) }
	if arrow-tip != auto { dict.insert("arrow-tip", arrow-tip) }
	if arrow-stroke != auto { dict.insert("arrow-stroke", arrow-stroke) }
	if alignment != auto { dict.insert("alignment", alignment) }
	if make-node != auto { dict.insert("make-node", make-node) }
	if make-edge != auto { dict.insert("make-edge", make-edge) }

	return dict
}

#let decorator(styling) = {
	return metadata((owner: "treechery", styling: styling))
}

#let node-styling(tree, tree-styling) = {
  let is-decorator(obj) = (
    obj.func() == metadata and 
    obj.value.at("owner", default: none) == "treechery" and 
    obj.value.at("styling", default: none) != none 
  )

  if is-decorator(tree.content) { return default-styling + tree-styling + tree.content.value.styling } 
  
  let styling = default-styling + tree-styling
  if repr(tree.content.func()) == "sequence" {
    for obj in tree.content.children {
      if is-decorator(obj) {
        styling += obj.value.styling // combine dictionaries
      }
    }
  }

  return styling
}

#let styling-to-make-functions(styling) = {
	let make-node = (origin, content) => fletcher.node(
		origin, 
		inset: styling.at("inset", default: default-styling.inset), 
		corner-radius: styling.at("radius", default: default-styling.radius), 
		shape: styling.at("shape", default: default-styling.shape), 
		stroke: styling.at("stroke", default: default-styling.stroke), 
		fill: styling.at("fill", default: default-styling.fill), 
		{
			set std.text(fill: styling.at("text", default: default-styling.text))
			align(center, content)
		}
	)
	let make-edge = (from, to) => fletcher.edge(
		from, 
		styling.at("arrow-tip", default: default-styling.arrow-tip), 
		to, 
		stroke: styling.at("arrow-stroke", default: default-styling.arrow-stroke)
	)

	if styling.at("make-node", default: none) != none { make-node = styling.make-node }
	if styling.at("make-edge", default: none) != none { make-edge = styling.make-edge }

	return (make-node: make-node, make-edge: make-edge)
}