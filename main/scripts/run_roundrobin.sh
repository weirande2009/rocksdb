#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

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
        tmp_dir="$folder/$subfolder_count"
        mkdir -p "$tmp_dir"
        # Get the workload file to tmp dir
        cp "$subfolder"/workload.txt "$tmp_dir"

        # Run the workload
        initialize_workspace 0 0 0 $tmp_dir

        # Run count_workload to compute the number of bytes that will be inserted to database
        ./count_workload $tmp_dir > $tmp_dir/out.txt
        while IFS='=' read -r key value; do
          # Set the variable based on the key-value pair
          eval "$key=$value"
        done < $tmp_dir/"workload_count.txt" 

        # run baseline
        run_baseline $total_written_bytes mnt/rocksdb $tmp_dir

        target_dir="$destination_dir/$folder_name/$subfolder_count"

        # Create the destination folder recursively if it doesn't exist
        mkdir -p "$target_dir"

        # Copy the specific files from the subfolder to the destination folder
        cp "$subfolder"/minimum.txt "$target_dir"
        cp "$subfolder"/log.txt "$target_dir"
        cp "$tmp_dir"/log.txt "$target_dir"/baseline.txt

        # Increase the subfolder count
        subfolder_count=$((subfolder_count+1))
      fi
    done
  fi
done
