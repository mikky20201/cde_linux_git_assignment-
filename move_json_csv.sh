#!/bin/bash

# SCRIPT: Move all CSV and JSON files into json_and_CSV folder

# Set variable for the source and destination directories
SOURCE_DIR="/Users/micahonyedikachitobias/Desktop/bash_assignment/raw/Transformed"
DEST_DIR="/Users/micahonyedikachitobias/Desktop/bash_assignment/json_and_CSV"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Move CSV and JSON files if they exist
shopt -s nullglob  
for file in "$SOURCE_DIR"/*.{csv,json}; do
    if [ -e "$file" ]; then
        mv "$file" "$DEST_DIR/"
        echo "Moved: $file -> $DEST_DIR/"
    fi
done

echo "All CSV and JSON files have been moved."
