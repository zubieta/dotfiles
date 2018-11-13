#!/bin/bash -xe

# Create a backup copy of the given file
function backup() {
    cp -R "$1" "$1.bak"
}

# Replace the original file with the backup
function unbackup() {
    mv -i "$1" "${1%.bak}"
}

# Define realpath function if not available
if [ -n "$(command -v realpath)" ]; then
    function realpath() {
        cd "$(dirname "$@")"
        echo "$(pwd)/$(basename "$@")"
    }
fi

# Swap the name of two files
function swap() {
    local TMP
    TMP="$(mktemp)"
    mv "$1" "$TMP"
    mv "$2" "$1"
    mv "$TMP" "$2"
}

# Extract WIFI password
function wifipass() {
    if [[ "$OSTYPE" == darwin* ]]; then
        security find-generic-password -ga "$1" | grep "password:"
    else
        echo "ERROR: Not implemented for this platform"
        return 1
    fi
}
