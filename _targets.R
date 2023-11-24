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

# This allows aspects of the pipeline to be run in parallel on multiple cores
options(clustermq.scheduler = "multiprocess")

# This specifies where my custom functions are
lapply(list.files("R",full.names = T),source)

# Here I define targets using static branching in order to run the pipeline on several input genomes. You can also use dynamic branching, but I prefer static branching for this pipeline
values <- tibble( 
  data_source = list.files(path="genomes",full.names = T) # create a list of input files for static branching
)

# Here I use tar_map to produce tar_targets for each of the input genomes
targets <- tar_map(
  values = values,
  tar_target(genomes,readDNAStringSet(data_source)), # load genomes
  tar_target(nuc_freq, get_nuc_freq(genomes)), # get nucleotide frequencies
  tar_target(nuc_freq_long, get_tidy_freq(nuc_freq)) # convert nucleotide frequencies into 'tidy' long form 
)

# your targets script must always end with calling a list of your targets. Here I call the above targets as well as a target that combines target 3 outputs for all genomes (nuc_freq_long), as well as a target that creates a plot with this combined ddata 
list(targets, # call all above targets as a list, this must be the last part of the _targets.R script!
     tar_combine(combined_tidy_freq,targets[3],command = rbind(!!!.x)), # need to specify tar_combine outside of the list where I define the targets, I tell R to combine all outputs of target 11, nuc_freq_long
     tar_target(freq_colplot,plot_freq(combined_tidy_freq)) # create a column plot of nucleotide frequencies
)

# Here are some common functions that you might find useful. Copy and paste them into the console to use. These are hashed out as, like I said above, you must end the targets script with a list of targets.

# tar_validate() # this checks for errors
# tar_visnetwork() # this creates a flow chart/DAG of the pipeline
# tar_make() # this runs the pipeline
# tar_load_everything() # this loads everything. Warning! will be slow if you have a lot of genomes in the ./genomes input folder