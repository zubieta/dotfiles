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

function aws-profile() {
    if [ $# -gt 1 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        echo "Usage: aws-profile <PROFILE>"
        echo
        echo "If no PROFILE is given then list the available profiles, otherwise"
        echo "set the AWS_PROFILE environment variable to it."
    elif [ $# -eq 0 ]; then
        grep '\[*\]' ~/.aws/credentials | cut -d '[' -f2 | cut -d ']' -f1
    else
        export AWS_PROFILE="$1"
    fi
}

function _aws_profiles() {
    local cur prev opts profiles
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD - 1]}"
    profiles=$(grep '\[*\]' ~/.aws/credentials | cut -d '[' -f2 | cut -d ']' -f1)
    opts="-h --help $profiles"

    if [[ $prev == "aws-profile" ]]; then
        # shellcheck disable=SC2207
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
        return 0
    fi
}
complete -F _aws_profiles aws-profile

# Connect to a rpi cluster node
# function fellow() {
#     if [ $# -eq 0 ] || [ $# -gt 1 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
#         echo "Usage: fellow <node name>"
#         echo
#         echo "SSH to a rpi cluster node (fellow)."
#         echo "The available nodes are frodo, sam, merry and pippin"
#     else
#         ssh root@"$1".local -p22222
#     fi
# }

# function _fellows() {
#     local cur prev opts
#     COMPREPLY=()
#     cur="${COMP_WORDS[COMP_CWORD]}"
#     prev="${COMP_WORDS[COMP_CWORD - 1]}"
#     opts="-h --help frodo sam merry pippin"

#     if [[ ${prev} == "fellow" ]]; then
#         # shellcheck disable=SC2207
#         COMPREPLY=($(compgen -W "$opts" -- "$cur"))
#         return 0
#     fi
# }
# complete -F _fellows fellow
