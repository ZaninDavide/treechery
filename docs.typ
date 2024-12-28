#import "src/lib.typ": decorate, styling, shapes, tree, timeline, staircase

// Prepare a few styling decorators
#let hexagonal = decorate(shape: shapes.hexagon)
#let dashed = decorate(arrow-stroke: (dash: "dashed"))
#let red = decorate(fill: red.lighten(40%))
#let green = decorate(fill: green.lighten(40%))
#let blue = decorate(fill: blue.lighten(40%))

#show list: tree.tree
- Animalia
	- Chordata #red
		- Mammalia #blue#hexagonal
			- Primates 
			- Carnivora #dashed#green
	- Arthropoda #blue
		- Insecta
			- Diptera #dashed

#v(2cm)

#show terms: timeline.timeline
/ 7.00: Wake up #blue
/ 8.00: Go to work #red
/ 12.00: Have lunch #green
/ 17.00: Go home #blue

#v(2cm)

#show terms: staircase.staircase
/ A: Wake up #blue
/ B: Go to work #red
/ C: Have lunch #green
/ D: Go home #blue

/*
#v(2cm)

- Living Being
	- Bacteria
		- coccals
		- bacillus
		- spirillum
		- vibrio
	- Eukaryota
		- Protista
		- Fungi
			- ascomycetes
			- zygomycetes
			- basidiomycetes
		- Animals
		- Plants
			- nonvascular
			- vascular
				- seedless
				- with seed
	- Archaea
		- euryarchaeota
		- crenarchaeota
		- korarchaeota

#{repr([
+ Parola
	+ Parola
+ Parola
])}
*/