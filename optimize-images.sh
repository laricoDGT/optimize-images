#!/bin/bash

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-webp}"
QUALITY=82

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read img
do
filename=$(basename "$img")
name="${filename%.*}"

tmp=$(mktemp /tmp/imgXXXX.png)

magick "$img" -strip -interlace Plane -quality 90 "$tmp"

cwebp -q $QUALITY -m 6 -mt -af "$tmp" -o "$OUTPUT_DIR/$name.webp"

rm "$tmp"
done
