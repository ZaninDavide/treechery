#import "src/lib.typ": tree, decorator, styling, shapes, algorithms

#show list: tree
#let strong = decorator(styling(
	shape: shapes.hexagon, 
	fill: black, 
	text: white, 
	arrow-stroke: (dash: "dashed")
))

- Animalia
	- Chordata
		- Mammalia
			- Primates
			- Carnivora #strong
	- Arthropoda
		- Insecta #strong
			- Diptera
			- Zygentoma