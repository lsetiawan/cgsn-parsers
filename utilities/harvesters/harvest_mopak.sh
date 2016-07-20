#!/bin/bash
#
# Read the raw MOPAK data files from the Endurance Coastal Surface Moorings and
# create parsed datasets available in Matlab formatted .mat files for further
# processing and review.
#
# C. Wingard  2016-02-27

# Parse the command line inputs
if [ $# -ne 4 ]; then
    echo "$0: required inputs are the platform and deployment names, the dcl"
    echo "name, and the name of the file to process."
    echo "     example: $0 ce02shsm D00001 dcl12 20150505.mopak.log"
    exit 1
fi
PLATFORM=${1,,}
DEPLOY=${2^^}
DCL=${3,,}
FILE=`/bin/basename $4`

# Set the default directory paths
RAW="/home/ooiuser/data/raw"
PARSED="/home/ooiuser/data/parsed"
BIN="/home/ooiuser/bin/cgsn-parsers/parsers"
PYTHON="/opt/python2.7.11/bin/python"

# Setup the input and output filenames as well as the absolute paths
IN="$RAW/$PLATFORM/$DEPLOY/$DCL/mopak/$FILE"
OUT="$PARSED/$PLATFORM/$DEPLOY/mopak/${FILE%.log}.mat"

# Parse the file
if [ -e $IN ]; then
    $PYTHON $BIN/parse_mopak.py -i $IN -o $OUT
fi