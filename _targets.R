# Created by use_targets().

# Load the R environment 
library(renv)
library(targets)
library(tarchetypes)
library(tibble)
library(tidyverse)

# Set target options:
tar_option_set(
  packages = c("tidyverse","Biostrings","tidyr","tarchetypes","tibble","stringr","ggthemes") # packages that your targets need to run
)

# tar_make_clustermq() is an older (pre-{crew}) way to do distributed computing
# in {targets}, and its configuration for your machine is below.
options(clustermq.scheduler = "multiprocess")

# Run the R scripts in the R/ folder with your custom functions:
lapply(list.files("R",full.names = T),source)

# Here I define targets using static branching in order to run the pipeline on several input genomes

values <- tibble( 
  data_source = list.files(path="genomes",full.names = T) # create a list of input files for static branching
)

targets <- tar_map(
  values = values,
  tar_target(genomes,readDNAStringSet(data_source)), # load genomes
  tar_target(nuc_freq, get_nuc_freq(genomes)), # get nucleotide frequencies
  tar_target(nuc_freq_long, get_tidy_freq(nuc_freq)) # convert nucleotide frequencies into 'tidy' long form 
)

list(targets, # call all above targets as a list, this must be the last part of the _targets.R script!
     tar_combine(combined_tidy_freq,targets[3],command = rbind(!!!.x)), # need to specify tar_combine outside of the list where I define the targets, I tell R to combine all outputs of target 11, nuc_freq_long
     tar_target(freq_colplot,plot_freq(combined_tidy_freq)) # create a column plot of nucleotide frequencies
)

# tar_validate() # this checks for errors
# tar_visnetwork() # this creates a flow chart/DAG of the pipeline
# tar_make() # this runs the pipeline
tar_load_everything() # this loads everything. Warning! will be slow if you have a lot of genomes in the ./genomes input folder

freq_colplot
