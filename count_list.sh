#!/bin/bash

# Check if both a word list file and target text file are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <word_list_file> <text_file>"
  exit 1
fi

# Assign input arguments to variables
word_list_file=$1
text_file=$2

# Check if the files exist
if [ ! -f "$word_list_file" ]; then
  echo "Word list file not found!"
  exit 1
fi

if [ ! -f "$text_file" ]; then
  echo "Text file not found!"
  exit 1
fi

# Iterate through each word in the word list file
while IFS= read -r word; do
  # Call the count_word.sh script for each word
  ./count_word.sh "$word" "$text_file"
done < "$word_list_file"
