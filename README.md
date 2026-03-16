
# Image Optimizer (AVIF + WebP)

A fast local image optimization pipeline for developers.  
This script removes metadata, compresses images, and generates **AVIF** and **WebP** versions before uploading them to a server.

It is designed to be simple, fast, and suitable for static sites, CMS uploads, or deployment pipelines.

---

## Features

- Removes EXIF and metadata
- Converts JPG / JPEG / PNG images
- Generates **AVIF** and **WebP**
- Keeps original images untouched
- Preserves folder structure
- Uses **all CPU cores** for faster processing
- Skips already converted images

---

## Requirements

Install the required tools:

```bash
brew install imagemagick
brew install libavif
brew install webp
```

Verify installation:

```bash
magick -version
avifenc --version
cwebp -version
```

---

## Installation

1. Download the repository or unzip the package.
2. Make the script executable:

```bash
chmod +x optimize-images.sh
```

---

## Usage

Run inside a folder with images:

```bash
./optimize-images.sh
```

Specify input and output directories:

```bash
./optimize-images.sh ./images ./images-optimized
```

---

## Supported Input Formats

- JPG
- JPEG
- PNG

---

## Output Structure

Example:

```
images/
   hero.jpg
   blog/post1.png

images-optimized/
   avif/
      hero.avif
      blog/post1.avif

   webp/
      hero.webp
      blog/post1.webp
```

---

## Compression Settings

### AVIF

```
min 18
max 28
speed 3
```

Produces **very high visual quality** with strong compression.

### WebP

```
quality 82
method 6
autofilter enabled
```

Used as fallback for browsers without AVIF support.

---

## Typical Results

| Format | Size |
|------|------|
Original JPG | 1.2 MB |
WebP | ~300 KB |
AVIF | ~200 KB |

AVIF usually compresses **25–40% smaller than WebP** while maintaining similar visual quality.

---

## Recommended HTML Usage

```
<picture>
  <source srcset="image.avif" type="image/avif">
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="">
</picture>
```

---

## Notes

- Original images are never modified.
- Output images are stored in a separate folder.
- Designed for pre-deployment optimization workflows.
