#!/bin/bash

# "http://www.openslr.org/resources/19/TEDLIUM_release2.tar.gz"

if [[ -z $1 ]]; then
    echo "./ted.sh path-to-unpacked-TEDLIUM_release2"
    echo "This will process all files into ./data/ted in the current directory"
    exit -1
fi

src_path=$1
out_path=./data/ted

mkdir $out_path

stms=$(find $src_path -name *.stm)
for stm in $stms; do
    sph=${stm//stm/sph}
    # extract that base filename
    filename=$(basename $stm)
    filename=${filename/\.stm/}
    # construct the output filename
    mkdir $out_path/$filename
    while read line; do
        if [[ $line != *"ignore_time_segment_in_scoring"* ]]; then
            start=$(echo "$line" | cut -d ' ' -f 4)
            stop=$(echo "$line" | cut -d ' ' -f 5)
            len=$(echo "$stop - $start" | bc)
            text=$(echo "$line" | cut -d ' ' -f 7-)
            outname=$out_path/$filename/${start/\./_}-${stop/\./_}
            # "we 're" -> "we're"
            text=${text// \'/\'}
            # write wav and txt
            echo $filename $start $stop $len
            sox $sph $outname.wav trim $start $len channels 1 rate 16000
            echo "$text" > $outname.txt
        fi
    done <$stm
done
