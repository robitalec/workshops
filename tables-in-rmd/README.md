# Tables in Rmd
## Alec Robitaille

As part of a reproducible framework, integrating model results, etc



tinytex::install_tinytex

1. Intro to Markdown, knitr, tinytex, Yihui Xie
1. Basics of Rmarkdown
    + preamble
    + output formats
    + syntax
1. Tables in Markdown
    + Markdown syntax
    + Use https://www.tablesgenerator.com/markdown_tables
1. From data, what are code chunks
    + load data
    + label chunks
    + output figs/tabs


bookdown::pdf_document2


including pictures in tables
wicked cool rmd knitr kable stuff

* using ![]() syntax and LaTeX \includegraphics{}
* figure out a word document solution
https://stackoverflow.com/questions/25106481/add-an-image-to-a-table-like-output-in-r

flextable??

stargazer

Strategies that are Git diffable:
1. CSVs


http://rapporter.github.io/pander
## Models
ml <- with(lm(mpg ~ hp + wt), data = mtcars)
pander(ml)
pander(anova(ml))
pander(aov(ml))
