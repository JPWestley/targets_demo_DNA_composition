
get_nuc_freq <- function(genome) {
  x <- oligonucleotideFrequency(genome, width=1, step=1, with.labels=TRUE,as.prob=T,simplify.as="collapsed")
  df <- data.frame(as.list(x))
  return(df)
}


get_tidy_freq <- function(nuc_freq) {
  name <- as.character(substitute(nuc_freq))
  name <- str_sub(name, 18, -5)
  nuc_freq2 <- nuc_freq %>%
    mutate(species=name)
  nuc_freq2$species <- as.factor(nuc_freq2$species)
  nuc_freq_long <- gather(nuc_freq2, nucleotide,proportion, 1:4)
  return(nuc_freq_long)
}

plot_freq <- function(df) {
  ggplot(data=df,aes(x=species,y=proportion,fill=nucleotide))+
         geom_col()+ 
    theme_minimal()+
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
                                     axis.text=element_text(size=15),
                                     axis.title=element_text(size=18,face="bold"), legend.title=element_text(size=18,face="bold"))
}
