#import "@preview/cetz:0.3.1"
#import "../styling.typ": styling, node-styling
#import "../parser.typ": parse-term-list

#let staircase(
  term-styling: styling(), 
  description-styling: styling(), 
  width: 20em, 
  height: 3em, 
  dx: 1.5em, 
  dy: 0.5em, 
  show-side: false, 
  body
) = {
  let default-term-styling = (
    fill: auto,
		stroke: 0.5pt,
		text: black,
	)
	let default-description-styling = (
		fill: luma(90%),
		stroke: 0.5pt,
		text: black,
	)

  let x = 0
  cetz.canvas({
    import cetz.draw: *
    let cur = (0cm, 0cm)
    let parsed-list = parse-term-list(body)
    for (index, child) in parsed-list.children.enumerate() {
      let child-term-styling = node-styling(child.title, default-term-styling + term-styling)
      let child-description-styling = node-styling(child.content, default-description-styling + description-styling)
      if child-term-styling.fill == auto {
        child-term-styling.fill = child-description-styling.fill.darken(10%)
      }
      rect(
        cur, 
        (cur.at(0) + width, cur.at(1) + height), 
        fill: child-description-styling.fill, 
        stroke: child-description-styling.stroke
      )
      rect(
        cur, 
        (cur.at(0) + height, cur.at(1) + height), 
        fill: child-term-styling.fill, 
        stroke: child-term-styling.stroke
      )
      if dy > 0cm and not(index + 1 == parsed-list.children.len() and (not show-side)) {
        // Face 3D perspective
        line(
          (cur.at(0), cur.at(1) + height), 
          (cur.at(0) + height, cur.at(1) + height), 
          (cur.at(0) + height + dx, cur.at(1) + height + dy), 
          (cur.at(0) + dx, cur.at(1) + height + dy), 
          close: true,
          fill: child-term-styling.fill.darken(10%), 
          stroke: child-term-styling.stroke
        )
        line(
          (cur.at(0) + height, cur.at(1) + height), 
          (cur.at(0) + height + dx, cur.at(1) + height + dy), 
          (cur.at(0) + width + dx, cur.at(1) + height + dy), 
          (cur.at(0) + width, cur.at(1) + height), 
          close: true,
          fill: child-description-styling.fill.darken(10%), 
          stroke: child-description-styling.stroke
        )
      }
      if show-side {
        line(
            (cur.at(0) + width, cur.at(1)), 
            (cur.at(0) + width, cur.at(1) + height), 
            (cur.at(0) + width + dx, cur.at(1) + height + dy), 
            (cur.at(0) + width + dx, cur.at(1) + dy), 
            closed: true,
            fill: child-description-styling.fill.lighten(15%), 
            stroke: child-description-styling.stroke
        )
      }
      content((cur.at(0) + height / 2.0, cur.at(1) + height / 2.0), text(
        fill: child-term-styling.text, 
        child.title
      ))
      content((cur.at(0) + (width + height) / 2.0, cur.at(1) + height / 2.0), box(
        width: (width - height), 
        // height: height, 
        inset: 10pt, 
        fill: none, 
        child.content
      ))
      cur = (cur.at(0) + dx, cur.at(1) + height + dy)
    }
	})
}