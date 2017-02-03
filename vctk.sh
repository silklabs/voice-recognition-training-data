#!/bin/bash

# "http://homepages.inf.ed.ac.uk/jyamagis/release/VCTK-Corpus.tar.gz"

if [[ -z $1 ]]; then
    echo "./vctk.sh path-to-unpacked-TEDLIUM_release2"
    echo "This will process all files into ./data/ted in the current directory"
    exit -1
fi

src_path=$1
out_path=./data/vctk

mkdir $out_path

wavs=$(find $src_path -name *.wav)
for wav in $wavs; do
    txt=${wav/wav48/txt}
    txt=${txt/wav/txt}
    filename=$(basename $txt)
    filename=${filename/\.txt/}
    if [[ -f $wav && -f $txt ]]; then
      sox $wav $out_path/$filename.wav channels 1 rate 16000
      cp $txt $out_path/$filename.txt
    else
      echo "missing $wav $txt"
    fi
done
