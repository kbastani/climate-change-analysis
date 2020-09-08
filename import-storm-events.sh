#!/bin/bash

echo "Downloading CSV files from NOAA server..."

wget -m ftp://ftp.ncdc.noaa.gov:21/pub/data/swdi/stormevents/csvfiles

FILES=./ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/StormEvents_details-ftp_v1.0_*.csv
ZIPPED_FILES=./ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/StormEvents_details-ftp_v1.0_*.csv.gz
for f in $ZIPPED_FILES
do
  echo "Unzipping $f file..."
  # take action on each file. $f store current file name
  gunzip $f
done

# Move downloaded CSV files to subdirectory
mkdir rawdata
mv $FILES ./rawdata

# Clean up
echo "NOAA storm event data downloaded!"

echo "Cleaning up..."
rm -rf ./ftp.ncdc.noaa.gov
