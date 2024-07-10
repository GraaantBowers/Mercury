#!/bin/bash

# Define the source and target directories
SOURCE_DIR="md"
TARGET_DIR="wiki"

# Check if the SOURCE_DIR exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Check if there are any markdown files in the SOURCE_DIR
if [ -z "$(ls -A $SOURCE_DIR/*.md 2>/dev/null)" ]; then
    echo "Error: No markdown files found in the source directory '$SOURCE_DIR'."
    exit 1
fi

# Create the /wiki directory if it does not exist, or clean it if it does
if [ -d "$TARGET_DIR" ]; then
    rm -rf "$TARGET_DIR"/*
else
    mkdir -p "$TARGET_DIR"
fi

# Iterate over all markdown files in the /markdown directory
for markdown_file in "$SOURCE_DIR"/*.md; do
    # Extract the base name of the file (without directory and extension)
    base_name=$(basename "$markdown_file" .md)
    
    # Define the output HTML file path
    html_file="$TARGET_DIR/$base_name.html"
    
    # Run Pandoc to convert markdown to HTML using the specified template
    pandoc --template=template.html -f markdown+hard_line_breaks -t html -o "$html_file" "$markdown_file"
done
