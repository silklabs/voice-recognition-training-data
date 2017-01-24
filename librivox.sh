#!/bin/bash

# "http://www.openslr.org/resources/12/train-clean-100.tar.gz"
# "http://www.openslr.org/resources/12/train-clean-360.tar.gz"
# "http://www.openslr.org/resources/12/train-other-500.tar.gz"
# "http://www.openslr.org/resources/12/dev-clean.tar.gz"
# "http://www.openslr.org/resources/12/dev-other.tar.gz"
# "http://www.openslr.org/resources/12/test-clean.tar.gz"
# "http://www.openslr.org/resources/12/test-other.tar.gz"

if [[ -z $1 ]]; then
    echo "./ted.sh path-to-unpacked-librivox-files"
    echo "This will process all files into ./data/ted in the current directory"
    exit -1
fi

src_path=$1
out_path=./data/librivox

trans_files=$(find $src_path -name *.trans.txt)
for trans in $trans_files; do
    # extract that filename
    filename=${trans/\.trans.txt/}
    while read line; do
        tag=$(echo "$line" | cut -d ' ' -f 1)
        book=$(echo "$tag" | cut -d '-' -f 1)
        chapter=$(echo "$tag" | cut -d '-' -f 2)
        id=$(echo "$tag" | cut -d '-' -f 3)
        text=$(echo "$line" | cut -d ' ' -f 2-)
        text=${text,,} # lowercase
        mkdir -p ${out_path}/${book} 2> /dev/null
        outname=${out_path}/${book}/${book}-${chapter}-${id}
        sox ${filename}-${id}.flac $outname.wav channels 1 rate 16000
        echo $text > ${outname}.txt
    done <$trans
done
