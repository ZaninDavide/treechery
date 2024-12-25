#import "treechery.typ": tree
#import "algorithms.typ"
#import "styling.typ": styling, decorator
#import "@preview/fletcher:0.5.3": shapes

/// Same arguments as styling
#let decorate(..args) = decorator(styling(..args))