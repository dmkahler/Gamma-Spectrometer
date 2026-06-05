#! /bin/bash

# Check that a filename was provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <n42_file>"
    exit 1
fi

INPUT_FILE="$1"

# Check that the file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found."
    exit 1
fi

# Run the R script
Rscript plotN42.R "$INPUT_FILE"