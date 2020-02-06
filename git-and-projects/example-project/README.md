## Standard Folder Structure

It could be used for individual projects, making analyses **reproducible** and neat.

At the base of this idea is wrapping a project in a `.Rproj` file, improving portability by making all file-paths relative to the folder structure.
Read [here](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) for more info about Projects. 

Following a standardized folder structure will help keep things organized.

```
project/
└───README.md
└───input/
└───output/
└───R/
└───graphics/
```

A `README.md` file could have some useful information about the project.

The `/input` folder is for input data.

The `/output` folder is for output data.

The `/graphics` is for figures/tables, etc.

Finally, the `/R` folder is used to store all scripts.
If more than one script is needed for a project/analysis, make sure to number the scripts in the order they should be run. 

You will notice that all folders in the example directory have a *placeholder* file, since `Git` does not monitor folders, only their contents. This means it is necessary to place an empty file (or other placeholder) in each directory you would like to push to a repository. As the project develops, these placeholders will be deleted and replaced with relevant files.
