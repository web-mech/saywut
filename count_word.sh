#!/bin/bash

# Check if both a word and file are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <word> <file>"
  exit 1
fi

# Assign inputs to variables
word=$1
file=$2

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File not found!"
  exit 1
fi

# Count the occurrences of the word in the file (case insensitive)
count=$(grep -o -i "\b$word\b" "$file" | wc -l)

# Output the result
echo "The word '$word' appears $count times in the file '$file'."
