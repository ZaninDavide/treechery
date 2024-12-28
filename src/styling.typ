#import "@preview/fletcher:0.5.3"

// Helper function to create a dictionary which specifies styling options.
#let styling(
	shape: auto,
	inset: auto,
	fill: auto,
	stroke: auto, 
	radius: auto, 
	text: auto,
	arrow-tip: auto,
	arrow-stroke: auto,
	alignment: auto,
	width: auto,
	height: auto,
) = {
	let dict = (:)

	if shape != auto { dict.insert("shape", shape) }
	if inset != auto { dict.insert("inset", inset) }
	if fill != auto { dict.insert("fill", fill) }
	if stroke != auto { dict.insert("stroke", stroke) }
	if radius != auto { dict.insert("radius", radius) }
	if text != auto { dict.insert("text", text) }
	if arrow-tip != auto { dict.insert("arrow-tip", arrow-tip) }
	if arrow-stroke != auto { dict.insert("arrow-stroke", arrow-stroke) }
	if alignment != auto { dict.insert("alignment", alignment) }
	if width != auto { dict.insert("width", width) }
	if height != auto { dict.insert("height", height) }

	return dict
}

// Creates a decorator with the specified styling.
#let decorator(styling) = {
	return metadata((owner: "treechery", styling: styling))
}

// Creates a decorator with the specified styling options. It's equivalent to `decorator(styling: styling(...))` so it takes the same arguments as `styling`.
#let decorate(..args) = decorator(styling(..args))

#let node-styling(node-content, tree-styling) = {
  let is-decorator(obj) = (
    obj.func() == metadata and 
    obj.value.at("owner", default: none) == "treechery" and 
    obj.value.at("styling", default: none) != none 
  )

  if is-decorator(node-content) { return tree-styling + node-content.value.styling } 
  
  let styling = tree-styling
  if repr(node-content.func()) == "sequence" {
    for obj in node-content.children {
      if is-decorator(obj) {
        styling += obj.value.styling // combine dictionaries
      }
    }
  }

  return styling
}