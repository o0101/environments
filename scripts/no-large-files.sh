#!/bin/bash

# Set the maximum file size limit to 2 MB
MAX_FILE_SIZE=2097152

# Get the list of added or modified files
files=$(git diff --cached --name-only --diff-filter=AM)

for file in $files
do
  # Get the size of the file
  if [ -f "$file" ]; then
    file_size=$(wc -c < "$file")
  else
    continue
  fi

  # Check if the file size is greater than the limit
  if [ $file_size -gt $MAX_FILE_SIZE ]; then
    echo "Error: File $file is larger than $MAX_FILE_SIZE bytes."
    echo "Commit rejected."
    exit 1
  fi
done

# Continue with the commit if all files are within the limit
exit 0

