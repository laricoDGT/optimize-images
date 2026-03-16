#!/usr/bin/env bash

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-optimized}"

AVIF_MIN=18
AVIF_MAX=28
AVIF_SPEED=3

WEBP_QUALITY=82

CPU=$(sysctl -n hw.ncpu)

process_image() {

img="$1"

rel="${img#$INPUT_DIR/}"

dir=$(dirname "$rel")
name=$(basename "$rel")
base="${name%.*}"

mkdir -p "$OUTPUT_DIR/avif/$dir"
mkdir -p "$OUTPUT_DIR/webp/$dir"

avif_out="$OUTPUT_DIR/avif/$dir/$base.avif"
webp_out="$OUTPUT_DIR/webp/$dir/$base.webp"

if [ -f "$avif_out" ] && [ -f "$webp_out" ]; then
return
fi

tmp=$(mktemp /tmp/imgXXXX.png)

magick "$img" -strip -interlace Plane "$tmp"

if [ ! -f "$avif_out" ]; then
avifenc --min $AVIF_MIN --max $AVIF_MAX --speed $AVIF_SPEED "$tmp" "$avif_out"
fi

if [ ! -f "$webp_out" ]; then
cwebp -q $WEBP_QUALITY -m 6 -mt -af "$tmp" -o "$webp_out" >/dev/null 2>&1
fi

rm "$tmp"

}

export INPUT_DIR OUTPUT_DIR AVIF_MIN AVIF_MAX AVIF_SPEED WEBP_QUALITY
export -f process_image

find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | \
xargs -P "$CPU" -I {} bash -c 'process_image "$@"' _ {}
