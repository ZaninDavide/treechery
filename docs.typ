#import "src/lib.typ": tree.tree, tree.algorithms, decorate, styling, shapes, tree.parse-bullet-list, timeline.timeline

#show list: tree.with(algorithm: algorithms.waterfall)
#set page(width: 30cm)

#show terms: timeline.with(date-styling: styling(width: 7em), description-styling: styling(width: 7em))

// Prepare a few styling decorators
#let hexagonal = decorate(shape: shapes.hexagon)
#let strong = decorate(fill: black, text: white)
#let dashed = decorate(arrow-stroke: (dash: "dashed"))

- Animalia
	- Chordata
		- Mammalia #strong
			- Primates
			- Carnivora
				- Lorem
				- Ipsum
	- Arthropoda
		- Insecta
			- Diptera
				- Lorem
					- Lorem
					- Ipsum
				- Ipsum
			- Zygentoma
				- Dolor

/ 1910: Odi et amo quare id faciam fortasse requiris nescio sed fieri sentio et excrucior
/ 1915: Lorem Ipsum
/ 1920: Lorem Ipsum
/ 1925: Lorem Ipsum
/ 1932: Lorem Ipsum
/ 1937: Lorem Ipsum

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