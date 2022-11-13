#!/bin/bash

# PDF Compression - Single file
echo "Compressing $1"
ps2pdf -dPDFSETTINGS=/ebook "$1" temp && mv -f temp "$1"