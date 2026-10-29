library(xml2)
library(lubridate)
library(ggplot2)

# fn <- "example/SPEC0135.N42"
fn <- file.choose()
root <- strsplit(fn, ".N42")[[1]]

# Read the file
doc <- read_xml(fn) # XML read
doc <- xml_ns_strip(doc)

# Mn-54
# 22 Oct 2026
# example/SPEC0138.N42

startTime <- xml_text(xml_find_first(doc, ".//StartTime"))
startTime <- force_tz(ymd_hms(startTime), tz = "America/New_York") # CHECK TIME ZONE
per <- xml_text(xml_find_first(doc, ".//LiveTime"))
per <- as.numeric(strsplit(strsplit(per, "PT")[[1]][2], "S")[[1]]) # in seconds
if (per > 7200) {
     AT <- paste0("Aquisition time: ", round(per/3600, 2), " hours")
} else {
     AT <- paste0("Aquistion time: ", round(per/60, 2), " minutes")
}

y <- xml_text(xml_find_first(doc, ".//ChannelData")) # Extract counts data marked as "ChannelData"
counts <- scan(text = y, quiet = TRUE)

x <- xml_text(xml_find_all(doc, ".//ArrayXY//Y")) # Extract energy data; the energy is in keV
energy <- sapply(strsplit(x, "\\s+"), function(z) as.numeric(z[1])) # This pulls out the first value of each set (they are stored in pairs with zeros), the "function" is a dummy function that is defined as pulling the first value.

spectrum <- data.frame(energy, counts)

nuclide <- xml_text(xml_find_first(doc, ".//NuclideName"))
#nuclide <- "Mn-54"

ggplot(spectrum) +
     geom_line(aes(x = energy, y = counts)) +
     scale_y_log10() +
     #scale_x_log10(limits = c(10, 3100)) +
     #geom_vline(xintercept = 238.6) + # Pb-212
     #geom_vline(xintercept = 511) + # Y-88
     geom_vline(xintercept = 834.848) + # Mn-54
     labs(title = nuclide, subtitle = AT, x = "Energy (keV)", y = "Counts") +
     theme(panel.background = element_rect(fill = "white", colour = "black")) + 
     theme(aspect.ratio = 0.62) +
     theme(axis.title = element_text(face = "plain", size = 14)) +
     theme(axis.text = element_text(face = "plain", size = 14))


