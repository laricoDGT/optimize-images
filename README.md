# Image Optimization to AVIF

This script optimizes images locally before uploading them to a server.  
It removes metadata and converts images to the **AVIF** format, which typically provides significantly better compression than JPG, PNG, or WebP while maintaining high visual quality.

## Features

- Removes EXIF and metadata
- Converts JPG / JPEG / PNG to AVIF
- Keeps original images untouched
- Outputs optimized files into a separate directory
- Suitable for preparing images before deployment

## Requirements

Install the required tools:

```bash
brew install imagemagick
brew install libavif
```


## Verify installation:
```
magick -version
avifenc --version
```
## Script
optimize-images-avif.sh

```
#!/bin/bash

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-avif}"
QUALITY=45

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f $begin:math:text$ \-iname \"\*\.jpg\" \-o \-iname \"\*\.jpeg\" \-o \-iname \"\*\.png\" $end:math:text$ | while read img
do
filename=$(basename "$img")
name="${filename%.*}"

tmp=$(mktemp /tmp/imgXXXX.png)

magick "$img" -strip -interlace Plane "$tmp"

avifenc --min 30 --max $QUALITY --speed 4 "$tmp" "$OUTPUT_DIR/$name.avif"

rm "$tmp"
done
```

## Make Script Executable

chmod +x optimize-images-avif.sh

## Usage
Run in the current folder:
``
./optimize-images-avif.sh
``
Specify input and output directories:
```
./optimize-images-avif.sh ./images ./images-avif
```

## Example Structure
Before:
```
images/
  photo1.jpg
  photo2.png
```
After:
```
images/
  photo1.jpg
  photo2.png

images-avif/
  photo1.avif
  photo2.avif
```

