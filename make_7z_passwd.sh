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
ARCHIVE_NAME="$(date +%Y-%m-%d_%H-%M)_${DIR_NAME}.7z"

# Prompt for password before creating archive
read -s -p "Enter password: " PASSWORD
echo
read -s -p "Confirm password: " PASSWORD_CONFIRM
echo

if [ "$PASSWORD" != "$PASSWORD_CONFIRM" ]; then
    echo "Error: Passwords do not match."
    exit 1
fi

echo "Creating encrypted archive '$ARCHIVE_NAME' from files in '$DIR_PATH'..."

# -mhe=on encrypts also file headers (hides filenames)
7z a -p"$PASSWORD" -mhe=on "$ARCHIVE_NAME" "$DIR_PATH"

# Check if the archive was created successfully
if [ $? -eq 0 ]; then
    FILE_COUNT=$(7z l -p"$PASSWORD" "$ARCHIVE_NAME" | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" | wc -l)
    ARCHIVE_SIZE=$(du -sh "$ARCHIVE_NAME" | cut -f1)
    echo "Success! Archive '$ARCHIVE_NAME' created."
    echo "  - Files archived : $FILE_COUNT"
    echo "  - Archive size   : $ARCHIVE_SIZE"
else
    echo "Error: Failed to create archive."
    exit 1
fi
