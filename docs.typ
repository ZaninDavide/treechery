#import "src/lib.typ": treechery, node, custom_node

#show list: treechery
#let strong = node(fill: black, text: white)

- Animalia
	- Chordata
		- Mammalia
			- Primates
			- Carnivora #strong
	- Arthropoda
		- Insecta
			- Diptera
			- Zygentoma