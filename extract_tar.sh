#!/bin/bash

# Validate input argument
if [ $# -eq 0 ]; then
    echo "Error: No file path provided."
    echo "Usage: $0 <archive_file>"
    exit 1
fi

FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "Error: '$FILE' is not a valid file."
    exit 1
fi

echo "Extracting '$FILE'..."

# Extract based on file extension and count extracted files
case "$FILE" in
    *.tar)
        tar -xf "$FILE"
        FILE_COUNT=$(tar -tf "$FILE" | grep -v '/$' | wc -l)
        ;;
    *.tar.gz|*.tgz)
        tar -xzf "$FILE"
        FILE_COUNT=$(tar -tzf "$FILE" | grep -v '/$' | wc -l)
        ;;
    *.7z)
        7z x "$FILE"
        FILE_COUNT=$(7z l "$FILE" | tail -1 | awk '{print $5}')
        ;;
    *)
        echo "Error: Unsupported format '$FILE'."
        exit 1
        ;;
esac

# Report result
if [ $? -eq 0 ]; then
    echo "Success! '$FILE' extracted."
    echo "  - Files extracted: $FILE_COUNT"
else
    echo "Error: Failed to extract archive."
    exit 1
fi
