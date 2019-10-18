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
There are some better examples out there, check [this]() and [that]() and over [here](). 


# Methods
Look at the diamonds we research. See Table \ref:diamonds

(ref:diamonds) Look at these diamonds. 

\begin{table}[t]

\caption{(\#tab:unnamed-chunk-2)(ref:diamonds)}
\centering
\begin{tabular}{llllll}
\toprule
  &     carat &        cut & color &    clarity &     depth\\
\midrule
 & Min.   :0.200 & Fair     : 1610 & D: 6775 & SI1    :13065 & Min.   :43.0\\
 & 1st Qu.:0.400 & Good     : 4906 & E: 9797 & VS2    :12258 & 1st Qu.:61.0\\
 & Median :0.700 & Very Good:12082 & F: 9542 & SI2    : 9194 & Median :61.8\\
 & Mean   :0.798 & Premium  :13791 & G:11292 & VS1    : 8171 & Mean   :61.8\\
 & 3rd Qu.:1.040 & Ideal    :21551 & H: 8304 & VVS2   : 5066 & 3rd Qu.:62.5\\
\addlinespace
 & Max.   :5.010 &  & I: 5422 & VVS1   : 3655 & Max.   :79.0\\
 &  &  & J: 2808 & (Other): 2531 & \\
\bottomrule
\end{tabular}
\end{table}
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

1. reorder some of these sections (wow, look the toc changes)
1. reorder the code chunks (hmm will the figure numbers change?)
1. change the data, and notice the plots change (reproducible, neat!)
1. Change the output format
1. Change something and look at git

\newpage 

# References
