#!/bin/bash

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-avif}"
QUALITY=45

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read img
do
filename=$(basename "$img")
name="${filename%.*}"

tmp=$(mktemp /tmp/imgXXXX.png)

magick "$img" -strip -interlace Plane "$tmp"

avifenc --min 30 --max $QUALITY --speed 4 "$tmp" "$OUTPUT_DIR/$name.avif"

rm "$tmp"
done
