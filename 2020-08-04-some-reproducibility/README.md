# Some Reproducibility

Alec L. Robitaille

2020-08-04


[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/robit.a%2Fsome-reproducibility-example/master?urlpath=rstudio)

Workshop focusing on some parts of reproducible research: capturing the computational environment
and automating workflows.

Focusing on two packages:

* [`renv`](https://rstudio.github.io/renv)
* [`drake`](https://github.com/ropensci/drake/)


### Example projects

Starting with two completed examples, we'll look at how `renv` help us track packages (and versions) used for a 
project and how `drake` helps us explictly define and track our workflow. 
A bit trickier to setup Binder with `renv`, so the 


Two example projects:

1. Script based workflow
2. Function based workflow

### Binder

Binder is used to run this workshop in the browser and I've isolated the example
in a separate repository here: [robit.a/some-reproducibility-example](https://gitlab.com/robit.a/some-reproducibility-example). 


### Exercise

1. Open the Binder link [here](https://mybinder.org/v2/gl/robit.a%2Fsome-reproducibility-example/master?urlpath=rstudio)
1. Open one of the example RStudio projects. 
1. Run `drake::r_vis_drake_graph()` to see the targets and outputs. 
1. Run `drake::r_make()` to make them. 
1. Explore the outputs, figures, etc. 
1. Make some changes, vis, edit, vis. 93 till infinity.
1. Compare: scripts vs functions
1. Optionally, zip up your results to take them home with you (`zip::zip('mine.zip', 'mine')`)



### Resources

#### `drake`

* [`drake` book](https://books.ropensci.org/drake/), [`drake` docs](https://docs.ropensci.org/drake/), so many resources!
* [Miles McBain's drake post](https://milesmcbain.xyz/the-drake-post/)


#### `renv`

* [renv docs](https://rstudio.github.io/renv/articles/renv.html)


#### General Reproducibility

* [rOpenSci Guide](https://ropensci.github.io/reproducibility-guide/sections/introduction/)
* [The Turing Way](https://the-turing-way.netlify.app/welcome)

