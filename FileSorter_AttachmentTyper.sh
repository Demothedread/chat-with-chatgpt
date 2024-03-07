#!/bin/bash

# Base directory containing the files
base_directory="/Users/jreback/Library/CloudStorage/GoogleDrive-jmreback@gmail.com/My Drive/Hesperia Report- Resources"

# Directories for categorized files
mkdir -p "${base_directory}/articles"
mkdir -p "${base_directory}/images"
mkdir -p "${base_directory}/photographs"

# Sort files into categories based on MIME types or file extensions
find "$base_directory" -type f | while read file; do
    mime_type=$(file --mime-type -b "$file")
    case "$mime_type" in
        text/*)
            mv "$file" "${base_directory}/articles/"
            ;;
        image/*)
            if [[ "$file" == *"photo"* ]]; then # Simple heuristic, needs refinement
                mv "$file" "${base_directory}/photographs/"
            else
                mv "$file" "${base_directory}/images/"
            fi
            ;;
        # Add more cases as needed
    esac
done
