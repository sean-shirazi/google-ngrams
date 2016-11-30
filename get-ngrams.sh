#!/bin/bash

SCRIPT=$(basename $0)
USAGE="USAGE: $SCRIPT n prefix [CORPUS] [VERSION], e.g.: $SCRIPT 3 aa"

source "$(dirname $0)/common.sh"

n=${1?$USAGE}
prefix=${2?$USAGE}

CORPUS=${3-$CORPUS}
VERSION=${4-$VERSION}

echo "n: $n"
echo "prefix: $prefix"
echo "corpus: $CORPUS"
echo "version: $VERSION"



# prefix="${echo $prefix | tr ' ' ,}"

for p in $prefix
do
    
    echo "Fetching $p..."
    URL="http://storage.googleapis.com/books/ngrams/books/googlebooks-$CORPUS-${n}gram-$VERSION-${p}.gz"

    echo "$URL"

    curl -s "$URL" | \
        gunzip | \
        awk -f "$(dirname $0)/process-ngrams.awk" | \
        LC_ALL=C sort | \
        bzip2 > "$CORPUS-${n}gram-$VERSION-${p}.csv.bz2"

done
