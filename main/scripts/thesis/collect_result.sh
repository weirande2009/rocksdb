#!/bin/bash

# Check the number of parameters
if ! [ $# -eq 2 ]; then
    echo 'in this shell script, there will be two parameters, which are:'
    echo '1. the source directory'
    echo '2. the destination directory'
    exit 1
fi

# Set the source directory where the folders are located
source_dir="$1"

# Set the destination directory where the files will be copied
destination_dir="$2"
# Make the destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Iterate through each folder in the source directory
for folder in "$source_dir"/*; do
  if [ -d "$folder" ]; then
    # Get the folder name
    folder_name=$(basename "$folder")
    # Count the number of subfolders
    subfolder_count=1
    # Iterate all folders in the folder
    for subfolder in "$folder"/*; do
      if [ -d "$subfolder" ]; then
        # Increase the subfolder count
        subfolder_count=$((subfolder_count+1))

        target_dir="$destination_dir/$folder_name/$subfolder_count"

        # Create the destination folder recursively if it doesn't exist
        mkdir -p "$target_dir"

        # Copy the specific files from the subfolder to the destination folder
        cp "$subfolder"/minimum.txt "$target_dir"
        cp "$subfolder"/log.txt "$target_dir"
        cp "$subfolder"/result.txt "$target_dir"
        cp "$subfolder"/content.txt "$target_dir"
        rm -rf "$subfolder"/workload.txt
      fi
    done
  fi
done
