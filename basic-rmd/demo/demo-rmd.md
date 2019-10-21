---
title: Wicked cool demo
author: Alec Robitaile
header-includes: 
  - \usepackage{lipsum}
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
\lipsum[2-4]

# Methods
Look at the diamonds we research. See Table \@ref(tab:diamonds-tab)


(ref:diamonds) Look at these diamonds. 

\lipsum[3-8]



\begin{table}

\caption{(\#tab:diamonds-tab)(ref:diamonds)}
\centering
\begin{tabular}[t]{llllll}
\toprule
  &     carat &        cut & color &    clarity &     depth\\
\midrule
 & Min.   :0.2000 & Fair     : 1610 & D: 6775 & SI1    :13065 & Min.   :43.00\\
 & 1st Qu.:0.4000 & Good     : 4906 & E: 9797 & VS2    :12258 & 1st Qu.:61.00\\
 & Median :0.7000 & Very Good:12082 & F: 9542 & SI2    : 9194 & Median :61.80\\
 & Mean   :0.7979 & Premium  :13791 & G:11292 & VS1    : 8171 & Mean   :61.75\\
 & 3rd Qu.:1.0400 & Ideal    :21551 & H: 8304 & VVS2   : 5066 & 3rd Qu.:62.50\\
\addlinespace
 & Max.   :5.0100 &  & I: 5422 & VVS1   : 3655 & Max.   :79.00\\
 &  &  & J: 2808 & (Other): 2531 & \\
\bottomrule
\end{tabular}
\end{table}
## Study Area

<!--
![](www.some-study-area-pic.jpg)

-->

# Results


With a random example dataset, we can produce a random example Figure \@ref(fig:clarity-fig).

(ref:clarity) The relationship between clarity and carat. Who knows anything about diamonds?

\lipsum[2]


![(\#fig:clarity-fig)(ref:clarity)](demo-rmd_files/figure-latex/clarity-fig-1.pdf) 


Some more interesting things about diamonds in Figure \@ref(fig:color-fig)
 
(ref:color) The relationship between color and carat, colored by carat. Huh, look at that, I'm representing the same information in two different ways. Feels like that's an unnecessary (though aesthetically pleasant) thing to do. 

\lipsum[1]


![(\#fig:color-fig)(ref:color)](demo-rmd_files/figure-latex/color-fig-1.pdf) 

# Discussion

Some statement requiring a citation [@webber2018]. 

\lipsum[3]

# Cool things to try:

1. reorder some of these sections (wow, look the toc changes)
1. reorder the code chunks (hmm will the figure numbers change?)
1. change the data, and notice the plots change (reproducible, neat!)
1. Change the output format
1. Change something and look at git

\newpage 

# References
