
# Functions in R

A workshop delivered by Alec Robitaille to the Wildlife Evolutionary
Ecology Lab at Memorial University on October 25 2018.

``` bash
tree
```

    ## .
    ## ├── Functions-In-R.Rproj
    ## ├── input
    ## │   ├── b2015.csv
    ## │   ├── b2016.csv
    ## │   └── b2017.csv
    ## ├── Makefile
    ## ├── presentation
    ## │   ├── extra.css
    ## │   ├── Functions-In-R_files
    ## │   │   └── remark-css-0.0.1
    ## │   │       ├── metropolis.css
    ## │   │       └── metropolis-fonts.css
    ## │   ├── Functions-In-R.html
    ## │   ├── Functions-In-R.Rmd
    ## │   ├── images
    ## │   │   └── f7_2_profvis_monopoly.png
    ## │   └── macros.js
    ## ├── R
    ## │   ├── Chunks-FunctionsInR.R
    ## │   ├── Setup-FunctionsInR.R
    ## │   └── Worksheet-FunctionsInR.R
    ## ├── README.md
    ## └── README.Rmd
    ## 
    ## 6 directories, 17 files

## Details

The presentation is found in the `core` repo at
`core/Workshops/presentation/Functions-In-R.html`

Pull the `core` repo to check out the source. This presentation was
written in `RMarkdown` using the `xaringan` package by Yihui Xie.

The code chunks are pulled out of the presentation and stored in
`R/Chunks-FunctionsInR.R`.

The setup script (`R/Setup-FunctionsInR.R`) is combined with the code
chunks to produce a worksheet (`R/Worksheet-FunctionsInR.R`).

Follow along with this worksheet…

### Directions

1.  Open the Functions-In-R project (`Functions-In-R.Rproj`) as we go
    through the presentation.

2.  Open the Workseet.

3.  Load libraries, generate fake data, etc. Data for this presentation
    is stored in an `input` folder.
    
    Section label `### From Chunks-From-FunctionsInR.R ----` indicates
    the beginning of the chunks from the presentation.

4.  Run through the examples of excess typing from copy+paste.

5.  Make the `calc` function instead.

6.  Use it 3 ways.

7.  Learn about formals, body and environment. Try this with another
    function you use often\!

8.  Three examples of using subsets of your data.

9.  More examples of functions.

10. Comparison of using the `seq_along` or a unique combination
    `data.table`.
