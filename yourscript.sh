#!/bin/bash

# Set default value for -n option
num_entries=8

# Function to print usage
usage() {
    echo "Usage: $0 [-d] [-n N] dir1 [dir2 ...]"
    echo "Options:"
    echo "  -d: List files and directories"
    echo "  -n N: List top N entries (default: $num_entries)"
}

# Parse options
while getopts ":dn:" opt; do
    case $opt in
        d)
            show_files=true
            ;;
        n)
            num_entries=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

# Check if at least one directory is provided
if [ $# -eq 0 ]; then
    echo "Error: No directory specified" >&2
    usage
    exit 1
fi

# Loop through directories
for dir in "$@"; do
    echo "Disk usage for directory: $dir"
    if [ "$show_files" = true ]; then
        echo "Files and directories:"
        du -hs "$dir" | sort -rh | head -n "$num_entries"
    else
        echo "Directories only:"
        du -hs "$dir" | sort -rh | head -n "$num_entries" | awk '$2 ~ /\//'
    fi
    echo
done
