# dna-seq-comp

This pipeline takes .fna files as input, and gets the nucleotide, dinucelotide, and trinucleotide frequencies, as well as dinucelotide and trinucleotide transition matrices. Additionally it produces the transition matrices as heatmaps for easy visual inspection, as well as a column plot of nucleotide frequencies for all input genomes.

## Dependencies
This pipeline was built in R version 4.2.2. It has not been tested with other versions of R.

The following R packages are required.  

_targets_  
_tarchetypes_  
_tidyverse_  
_Biostrings_  
_tidyr_  
_tibble_  
_stringr_  
_ggthemes_  

## Using this pipeline

To run this pipeline on your own genomes, clone the repository and install the relevant R packages. Put your .fna files into the ./genomes folder. Open the project in RStudio via dna-seq-comp.Rproj and run lines 4-7 of the _targets.R file to load the packages used within the _targets.R file (note packages used only in the functions file, ./R/functions.R, will be loaded by targets automatically via lines 10-12).  

Now you can enter `tar_make()` into the console, to run the pipeline on your input genomes.  

All ouput objects will be in the directory ./_targets/objects. These can all be loaded at once with the command `tar_load_everything()`, or individual objects can be loaded with `tar_read("object name")`.

