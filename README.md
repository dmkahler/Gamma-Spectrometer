# N42 Spectral Data Processing and Visualization

This repository contains R-based tools for reading, parsing, and visualizing gamma spectroscopy data stored in ANSI N42 format (`.n42` files). The workflow extracts spectral counts and calibration information directly from XML-based instrument outputs and generates publication-ready visualizations using `ggplot2`.

## Overview

The codebase provides functionality to:

- Parse `.n42` files and extract spectral data (channel counts)
- Extract calibration metadata (energy/channel mapping)
- Convert raw spectra into analyzable data frames
- Visualize spectra in both channel and energy space
- Support reproducible analysis workflows for radiation detection data

## Instrument Information

- **Instrument:** RIIDEye M-G
- **Manufacturer/Model:** Thermo Scientific
- **Detector Type:** _________________________
- **Calibration Method:** _____________________

## Methods


## Requirements

R packages required:

- `xml2`
- `ggplot2`

## Usage

Download the scripts (.R and .sh) to a working directory.

chmod +x run_spectrum.sh

./run_spectrum.sh sample.n42

## Contributing

Please fork in GitHub and provide, in a public repository, a Pull Request for updates.  It would also be helpful to contact me directly so I am aware of the contribution.  Thank you.


