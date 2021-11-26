
# Personal R Packages

A workshop delivered by Alec Robitaille to the Wildlife Evolutionary
Ecology Lab at Memorial University on 2018-10-25.

``` bash
tree
```

    ## [01;34m.[00m
    ## ├── [01;34minput[00m
    ## │   ├── b2015.csv
    ## │   ├── b2016.csv
    ## │   └── b2017.csv
    ## ├── Makefile
    ## ├── personal-r-packages.Rproj
    ## ├── [01;34mR[00m
    ## │   ├── Chunks-PersonalPackages.R
    ## │   ├── PersonalPackages-Worksheet.R
    ## │   ├── Setup-PersonalPackages.R
    ## │   └── Worksheet-PersonalPackages.R
    ## ├── README.Rmd
    ## ├── [01;34mslides[00m
    ## │   ├── extra.css
    ## │   ├── [01;34mimages[00m
    ## │   │   ├── choose-a-license.png
    ## │   │   ├── DESCRIPTION.png
    ## │   │   └── toast_DESCRIPTION.png
    ## │   ├── macros.js
    ## │   ├── [01;34mPersonal-R-Packages_files[00m
    ## │   │   └── [01;34mremark-css-0.0.1[00m
    ## │   │       ├── metropolis.css
    ## │   │       └── metropolis-fonts.css
    ## │   ├── Personal-R-Packages.html
    ## │   └── Personal-R-Packages.Rmd
    ## └── [01;34mtoast[00m
    ##     ├── DESCRIPTION
    ##     ├── [01;34mtests[00m
    ##     │   ├── [01;34mtestdata[00m
    ##     │   │   ├── b2015.csv
    ##     │   │   ├── b2016.csv
    ##     │   │   └── b2017.csv
    ##     │   └── testthat.R
    ##     └── toast.Rproj
    ## 
    ## 9 directories, 25 files

## Details

The presentation is found in the `core` repo at
`core/Workshops/Personal-R-Packages/ presentation/Personal-R-Packages.html`

Pull the `core` repo to check out the source. This presentation was
written in `RMarkdown` using the `xaringan` package by Yihui Xie.

The code chunks are pulled out of the presentation and stored in
`R/Chunks-PersonalPackages.R`.

The setup script (`R/Setup-PersonalPackages.R`) is combined with the
code chunks to produce a worksheet (`R/Worksheet-PersonalPackages.R`).

Follow along with this worksheet…

### Directions

1.  Open the Personal-R-Packages project (`Personal-R-Packages.Rproj`)
    as we go through the presentation.

2.  Open the worksheet.

3.  Load libraries, generate fake data, etc. Data for this presentation
    is stored in an `input` folder.

    Section label `### From Chunks-From-PersonalPackages.R ----`
    indicates the beginning of the chunks from the presentation.

4.  Run through the examples of excess typing from copy+paste.

5.  Make the `calc` function instead.

6.  Use it 3 ways.

7.  Learn about formals, body and environment. Try this with another
    function you use often!

8.  Three examples of using subsets of your data.

9.  More examples of functions.

10. Comparison of using the `seq_along` or a unique combination
    `data.table`.
