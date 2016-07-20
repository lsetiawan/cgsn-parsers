#!/bin/bash
#
# Read the raw PCO2A data files from the Endurance Coastal Surface Moorings and
# create parsed datasets available in Matlab formatted .mat files for further
# processing and review.
#
# C. Wingard  2016-02-19

# Parse the command line inputs
if [ $# -ne 3 ]; then
    echo "$0: required inputs are the platform and deployment names, and the"
    echo "name of the file to process."
    echo "     example: $0 ce02shsm D00001 20150505.pco2a.log"
    exit 1
fi
PLATFORM=${1,,}
DEPLOY=${2^^}
FILE=`/bin/basename $3`

# Set the default directory paths
RAW="/home/ooiuser/data/raw"
PARSED="/home/ooiuser/data/parsed"
BIN="/home/ooiuser/bin/cgsn-parsers/parsers"
PYTHON="/opt/python2.7.11/bin/python"

# Setup the input and output filenames as well as the absolute paths
IN="$RAW/$PLATFORM/$DEPLOY/dcl12/pco2a/$FILE"
OUT="$PARSED/$PLATFORM/$DEPLOY/pco2a/${FILE%.log}.mat"

# Parse the file
if [ -e $IN ]; then
    $PYTHON $BIN/parse_pco2a.py -i $IN -o $OUT
fi