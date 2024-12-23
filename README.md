# treechery

This user-friendly [Typst](https://typst.app/) package turns bullet lists into beautiful [`fletcher`](https://typst.app/universe/package/fletcher) diagrams. Read the [`docs`](docs.pdf).

<p align="center">
    <img src="images/example.png" width="500" alt="Example"/>
</p>

```typ
#import "@local/treechery:0.1.0": tree, decorator, styling, shapes

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
```