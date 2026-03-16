#!/bin/bash

# Check if a directory path is provided
if [ $# -eq 0 ]; then
    echo "Error: No directory path provided."
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIR_PATH="$1"

# Check if the directory exists
if [ ! -d "$DIR_PATH" ]; then
    echo "Error: '$DIR_PATH' is not a valid directory."
    exit 1
fi

DIR_NAME=$(basename "$DIR_PATH")
ARCHIVE_NAME="$(date +%Y-%m-%d_%H-%M)_${DIR_NAME}.tar"

echo "Creating archive '$ARCHIVE_NAME' from files in '$DIR_PATH'..."

tar -cf "$ARCHIVE_NAME" -C "$(dirname "$DIR_PATH")" "$DIR_NAME"

# Check if the archive was created successfully
if [ $? -eq 0 ]; then
    FILE_COUNT=$(tar -tf "$ARCHIVE_NAME" | grep -v '/$' | wc -l)
    ARCHIVE_SIZE=$(du -sh "$ARCHIVE_NAME" | cut -f1)
    echo "Success! Archive '$ARCHIVE_NAME' created."
    echo "  - Files archived : $FILE_COUNT"
    echo "  - Archive size   : $ARCHIVE_SIZE"
else
    echo "Error: Failed to create archive."
    exit 1
fi
