#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_dir dest_dir" >&2
    exit 1
fi

# Assign arguments to variables
source_dir="$1"
dest_dir="$2"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory $source_dir does not exist" >&2
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$dest_dir" ]; then
    echo "Error: Destination directory $dest_dir does not exist" >&2
    exit 1
fi

# Get current timestamp
timestamp=$(date +%Y%m%d%H%M%S)

# Create backup archive
backup_file="$dest_dir/backup-$timestamp.tar.gz"
tar -czf "$backup_file" "$source_dir"

echo "Backup created: $backup_file"
