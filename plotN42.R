#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
fn <- args[1]

library(xml2)
library(ggplot2)

# fn <- "SPEC0133.N42"
root <- strsplit(fn, ".N42")[[1]]

# Read the file
doc <- read_xml(fn) # XML read
doc <- xml_ns_strip(doc)

y <- xml_text(xml_find_first(doc, ".//ChannelData")) # Extract counts data marked as "ChannelData"
counts <- scan(text = y, quiet = TRUE)

x <- xml_text(xml_find_all(doc, ".//ArrayXY//Y")) # Extract energy data; the energy is in keV
energy <- sapply(strsplit(x, "\\s+"), function(z) as.numeric(z[1])) # This pulls out the first value of each set (they are stored in pairs with zeros), the "function" is a dummy function that is defined as pulling the first value.

#coef <- as.numeric(strsplit(xml_text(xml_find_all(doc, ".//Coefficients"))[1], "\\s+")[[1]])
#energy <- coef[1] + coef[2] * energy + coef[3] * energy^2 + coef[4] * energy^3 # this produces a negative energy; not possible.

spectrum <- data.frame(energy, counts)

nuclide <- xml_text(xml_find_first(doc, ".//NuclideName"))

gg <- ggplot(spectrum) +
     geom_line(aes(x = energy, y = counts)) +
     scale_y_log10() +
     #scale_x_log10(limits = c(10, 3100)) +
     labs(title = nuclide, x = "Energy (keV)", y = "Counts") +
     theme(panel.background = element_rect(fill = "white", colour = "black")) + 
     theme(aspect.ratio = 0.62) +
     theme(axis.title = element_text(face = "plain", size = 14)) +
     theme(axis.text = element_text(face = "plain", size = 14))
ggsave(paste0(root, ".eps"), gg, device = "eps")

