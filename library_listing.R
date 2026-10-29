library(readr)
library(stringr)
library(dplyr)

get_nuclide <- function(f) {
     x <- read_file(f)
     nuclide <- strsplit(x, "Gamma\t\t")
     Name <- as.character(strsplit(nuclide[[1]][1], "\n"))
     return(Name)
}

get_values <- function(f) {
     x <- readLines(f)
     pattern <- "^Gamma\\s+([0-9.]+)[,\\s]+([0-9]+)"
     matches <- str_match(x, pattern)
     tab <- data.frame(
          Energy = as.numeric(matches[, 2])) %>%
          filter(!is.na(Energy))
     return(tab)
}

fs <- list.files("./library/", 
                 pattern = "*.nuc$", 
                 full.names = TRUE, 
                 recursive = TRUE, 
                 ignore.case=TRUE, 
                 include.dirs = TRUE)

for (i in 1:length(fs)) {
     fn <- fs[i]
     nm <- get_nuclide(fn)
     nrg <- get_values(fn)
     for (j in 1:nrow(nrg)) {
          y <- data.frame(nm, nrg$Energy[j])
          write_csv(y, "./library/energies.csv", append = TRUE)
     }
}



