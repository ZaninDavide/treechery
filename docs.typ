#import "src/lib.typ": tree.tree, tree.algorithms, decorate, styling, shapes, tree.parse-bullet-list

#show list: tree.with(algorithm: algorithms.waterfall)
#set page(width: 30cm)

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
/ Parola: traduzione
	/ Parola: traduzione
/ Parola: traduzione
/ Parola: traduzione
])}

#{repr([
+ Parola
	+ Parola
+ Parola
])}
*/