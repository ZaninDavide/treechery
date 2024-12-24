#import "src/lib.typ": tree, decorator, styling, shapes, algorithms

#show list: tree.with(algorithm: algorithms.centered-tree)

// Prepare a few styling decorators
#let hexagonal = decorator(styling(
	shape: shapes.hexagon, 
))
#let strong = decorator(styling(
	fill: black, 
	text: white, 
))
#let dashed = decorator(styling(
	arrow-stroke: (dash: "dashed")
))

- Animalia
	- Chordata
		- Mammalia #dashed
			- Primates
			- Carnivora #hexagonal#strong
	- Arthropoda
		- Insecta #strong#dashed
			- Diptera
			- Zygentoma