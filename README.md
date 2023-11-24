# dna-seq-comp

This pipeline takes .fna files as input, and gets the nucleotide, dinucelotide, and trinucleotide frequencies, as well as dinucelotide and trinucleotide transition matrices. Additionally it produces the transition matrices as heatmaps for easy visual inspection, as well as a column plot of nucleotide frequencies for all input genomes.

## Getting started
This pipeline was built in R version 4.2.2. It has not been tested with other versions of R. To use clone this git repo and load the project by double clicking on the targets_demo_DNA_DNA_composition.Rproj file.

The R environment needed to run this pipeline can be replicated by using the _renv_ package. First install and load renv by running the following lines of code in your R session.

  install.packages("renv")
  library(renv)

Now install all R packages used by this pipeline by running:

  ren::restore()
  
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

  library(targets,tarchetypes)

Note, packages used only in the functions file, ./R/functions.R, will be loaded by targets automatically).  

## Using this pipeline

To run this pipeline on your own genomes, put your .fna files into the ./genomes folder. Alternatively, there is a test genome included in this repo, _lamda_phage.fna_, that you can move into the genomes folder.

Now you can enter `tar_make()` into the console to run the pipeline.

All output objects will be in the directory ./_targets/objects. These can all be loaded at once with the command `tar_load_everything()`, or individual objects can be loaded with `tar_read("object name")`.

