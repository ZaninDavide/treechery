# treechery

This user-friendly [Typst](https://typst.app/) package turns bullet lists into beautiful trees. Read the [`docs`](docs.pdf).

<p align="center">
    <img src="images/example.png" width="500" alt="Example"/>
</p>

```typ
#import "@local/treechery:0.1.0": treechery, node

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
```