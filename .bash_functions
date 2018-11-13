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

# SWG to ICNS
function svg2icns() {
    if [[ "$OSTYPE" == darwin* ]]; then
        if [ $# -ne 1 ]; then
            echo "Usage: svg2icns filename.svg"
            exit 1
        fi

        FILENAME="$1"
        NAME=${FILENAME%.*}
        _TEMP=$(mktemp -d)
        TEMP="$_TEMP.iconset"
        mv "$_TEMP" "$TEMP"

        convert -background none -size 16x16 "$FILENAME" "$TEMP/icon_16x16.png"
        convert -background none -size 32x32 "$FILENAME" "$TEMP/icon_16x16@2x.png"
        cp "$TEMP/icon_16x16@2x.png" "$TEMP/icon_32x32.png"
        convert -background none -size 64x64 "$FILENAME" "$TEMP/icon_32x32@2x.png"
        convert -background none -size 128x128 "$FILENAME" "$TEMP/icon_128x128.png"
        convert -background none -size 256x256 "$FILENAME" "$TEMP/icon_128x128@2x.png"
        cp "$TEMP/icon_128x128@2x.png" "$TEMP/icon_256x256.png"
        convert -background none -size 512x512 "$FILENAME" "$TEMP/icon_256x256@2x.png"
        cp "$TEMP/icon_256x256@2x.png" "$TEMP/icon_512x512.png"
        convert -background none -size 1024x1024 "$FILENAME" "$TEMP/icon_512x512@2x.png"

        iconutil -c icns "$TEMP" -o "$NAME.icns"
        rm -rf "$TEMP"
    else
        echo "ERROR: Not implemented for this platform"
        return 1
    fi
}
