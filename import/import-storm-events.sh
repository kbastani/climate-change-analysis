#!/bin/bash

echo "Adding 'stormEvents' table to Pinot..."

# Adds a new Pinot table for the NOAA storm event data
/opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /opt/pinot/import/storm-events-table-config.json -schemaFile /opt/pinot/import/storm-events-schema.json -exec

echo "Downloading CSV files from NOAA server..."

wget -m ftp://ftp.ncdc.noaa.gov:21/pub/data/swdi/stormevents/csvfiles/StormEvents_details-ftp_v1.0_*.csv.gz

FILES=./ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/StormEvents_details-ftp_v1.0_*.csv
ZIPPED_FILES=./ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/StormEvents_details-ftp_v1.0_*.csv.gz
for f in $ZIPPED_FILES
do
  echo "Unzipping $f file..."
  # take action on each file. $f store current file name
  gunzip $f
done

# Move downloaded CSV files to subdirectory
mkdir /opt/pinot/import/rawdata
mv $FILES /opt/pinot/import/rawdata

# Clean up
echo "NOAA storm event data downloaded!"

echo "Cleaning up..."
rm -rf ./ftp.ncdc.noaa.gov

echo "Launching Pinot data ingestion job from raw storm event files..."

# Launch batch ingestion job from raw CSV files into Pinot
/opt/pinot/bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /opt/pinot/import/storm-events-job-spec.yml
