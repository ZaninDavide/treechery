#import "@preview/fletcher:0.5.3"
#import "../styling.typ": styling, node-styling
#import "../parser.typ": parse-term-list

#let draw-node(origin, content, styling) = {
	return fletcher.node(
		origin, 
    width: styling.at("width"),
    height: styling.at("height"),
		inset: styling.at("inset"), 
		corner-radius: styling.at("radius"), 
		shape: styling.at("shape"), 
		stroke: styling.at("stroke"), 
		fill: styling.at("fill"), 
		{
			set std.text(fill: styling.at("text"))
			align(styling.at("alignment"), content)
		}
	)
}

#let draw-arrow(from, to, styling) = {
	return fletcher.edge(
		from, 
		styling.at("arrow-tip"), 
		to, 
		stroke: styling.at("arrow-stroke"),
	)
}

#let timeline(term-styling: styling(), description-styling: styling(), spacing: 10pt, body) = {
	let default-term-styling = (
		shape: fletcher.shapes.chevron,
		inset: 0.6em,
		fill: auto,
		stroke: 0.5pt, 
		radius: 2pt, 
		text: black,
		arrow-tip: "-",
		arrow-stroke: 0.5pt,
		alignment: center,
    width: 8em,
    height: auto,
	)
	let default-description-styling = (
		shape: fletcher.shapes.rect,
		inset: 0.6em,
		fill: white,
		stroke: 0.5pt, 
		radius: 0pt, 
		text: black,
		arrow-tip: "-",
		arrow-stroke: 0.5pt,
		alignment: center,
    width: 8em,
    height: 6em,
	)

  let x = 0
	fletcher.diagram(spacing: spacing, {
    for child in parse-term-list(body).children {
      let title-style = node-styling(child.title, default-term-styling + term-styling)
      let content-style = node-styling(child.content, default-description-styling + description-styling)
			if title-style.fill == auto {
        title-style.fill = content-style.fill
      }
      let y = 2*calc.rem(x, 2) - 1
      draw-node((x, 0), child.title, title-style)
      draw-node((x, y), child.content, content-style)
      draw-arrow((x, 0), (x, y), content-style)
      x += 1
    }
	})
}