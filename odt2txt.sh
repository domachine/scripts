#!/bin/bash

SEDSCR='s|<text:p[^>]*>|\n|g
s/<[^>]+>//g'
TMP=$(mktemp -d)
trap clean_up TERM EXIT INT

clean_up() {
    test -z "$TMP" || rm -r "$TMP"
}

unzip_doc() {

    unzip "$1" -d "$TMP" >&2 || exit 1
    echo "Unzipped!" >&2
}

unzip_doc "$1"

if [ $# -eq 1 ]; then
    echo "$SEDSCR"|sed -rf- "$TMP/content.xml"
else
    echo "$SEDSCR"|sed -rf- "$TMP/content.xml" >"$2"
fi
