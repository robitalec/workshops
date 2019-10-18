---
title: Wicked cool demo
author: Alec Robitaile
output: 
  bookdown::pdf_document2:
    toc: true
    toc_depth: 3
    keep_md: true
    number_section: true
bibliography: refs.bib
---


\newpage

# Introduction



# Methods

## Study Area

<!--
![](www.some-study-area-pic.jpg)

-->

# Results

With a random example dataset, we can produce a random example figure \@ref{fig:clarity}. 

(ref:clarity) The relationship between clarity and carat. Who knows anything about diamonds?

![(\#fig:clarity)(ref:clarity)](demo-rmd_files/figure-latex/clarity-1.pdf) 

(ref:color) The relationship between color and carat, colored by carat. Huh, look at that, I'm representing the same information in two different ways. Feels like that's an unnecessary (though aesthetically pleasant) thing to do. 

![(\#fig:color)(ref:color)](demo-rmd_files/figure-latex/color-1.pdf) 

# Discussion

Some statement requiring a citation [@webber2018]. 


# Cool things to try:

1. reorder some of these sections
1. reorder the code chunks


\newpage 

# References
