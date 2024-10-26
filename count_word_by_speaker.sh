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

# Initialize an associative array to store counts by speaker
declare -A speaker_counts

# Process each line in the file
while IFS= read -r line; do
  # Extract the speaker label (assumes format "Speaker: Text")
  speaker=$(echo "$line" | cut -d':' -f1)
  # Extract the text after the colon
  text=$(echo "$line" | cut -d':' -f2-)

  # Count occurrences of the word in this line
  count=$(echo "$text" | grep -o -i "\b$word\b" | wc -l)

  # Add count to the speaker's total
  ((speaker_counts["$speaker"]+=count))
done < "$file"

# Output the result for each speaker
for speaker in "${!speaker_counts[@]}"; do
  echo "The word '$word' appears ${speaker_counts[$speaker]} times for $speaker"
done
