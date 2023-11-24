# R targets package demonstration: DNA sequence composition.

This pipeline takes .fna files as input, and gets the nucleotide, dinucelotide, and trinucleotide frequencies, as well as dinucelotide and trinucleotide transition matrices. Additionally it produces the transition matrices as heatmaps for easy visual inspection, as well as a column plot of nucleotide frequencies for all input genomes.

## Getting started
This pipeline was built in R version 4.2.2. It has not been tested with other versions of R. It additoinally requires Rstudio. To use, clone this git repo by entering the following into the command line:

`git clone https://github.com/JPWestley/targets_demo_DNA_composition/tree/main`

Or by downloading the repo by clicking on the green "Code" button, selecting "Download ZIP", and then unzipping the download.

Next, load the project by double clicking on the targets_demo_DNA_composition.Rproj file.

The R environment needed to run this pipeline can be replicated by using the _renv_ package. First install and load renv by running the following lines of code in your R session.


`install.packages("renv")`

`library(renv)`


Now install all R packages used by this pipeline by running:


`renv::restore()`


  
Alternatively, manuallly install the following R packages:

_targets_  
_tarchetypes_  
_tidyverse_  
_Biostrings_  
_tidyr_  
_tibble_  
_stringr_  
_ggthemes_  

Next load the packages needed for the workflow management:

`library(targets,tarchetypes)`

Note, packages used only in the functions file, ./R/functions.R, will be loaded by targets automatically).  

## Using this pipeline

This repo comes with three test genomes already in the genomes directory. These are the NCBI reference genomes for lambda phage, HIV, and the human mitochondrion.

Alternatively, to run this pipeline on your own genomes, put your .fna files into the ./genomes folder.

To run the pipeline enter `tar_make()` into the console.

All output objects will be in the directory ./_targets/objects. These can all be loaded at once with the command `tar_load_everything()`, or individual objects can be loaded with `tar_read("object name")`. 

If you are new to this pipeline, try running `tar_load_everything()`, and then `freq_colplot` to have a look at the variation in nucleotide frequencies for our different input genomes. 

## Why use this method?

Pipelines like this are great if you want to run the same processes on multiple similar input files. Here, we can get the nucleotide frequencies for whatever genomes we put into the genomes directory without having to write any additional code. Furthermore, if you run this pipeline on the three test genomes, and then add another genome to the genomes directory and run it again, targets will identify that it does not need to rerun _nuc_freq_ on the first three files, as they are unchanged. It will only rerun _nuc_freq_ on the new genome, and any functions downstream of this, i.e. the _nuc_freq_long_ function that alters the output of _nuc_freq_ to a long data format, the _combined_tidy_freq_ function that combines the outputs from different genomes, and the _freq_colplot_ function that produces the final figure. 

This efficiency advantage may not seem like much of a time saving in this example, but for many bigger datasets and more complex pipelines, unnecessarily running functions on data we already have outputs for can cost us lots of time (as well as unnecessarily increasing energy consumption, and for cloud based pipelines, costing extra money too!).



