# Standard Folder Structure
## Alec Robitaille

It can be used for individual projects or collaborative projects, making analyses organized, reproducible and neat.

At the base of this idea is wrapping a project in a `.Rproj` file, improving portability by making all file-paths relative to the root folder.
Read [here](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) for more info about Projects. 


```
project/
└───README.md
└───input/
└───output/
└───R/
└───graphics/
└───.gitignore
```

A `README.md` file should have basic information about the project, purpose, and any installation instructions. 

The `/input` folder is for input data.

The `/output` folder is for output data.

The `/R` folder is used to store all scripts.
If more than one script is needed for a project/analysis, make sure to number the scripts in the order they should be run. 

The `/graphics` is for figures/tables, etc.

The `.gitignore` file is to tell Git what files, or file types to ignore. More about this in the Git workshop. 
