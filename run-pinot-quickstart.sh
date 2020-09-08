#!/bin/bash

docker run --name "PinotClimateAnalytics" -ti -d -p 9000:9000 -p 8000:8000 apachepinot/pinot:0.5.0-SNAPSHOT-c223dfcfb-20200821 QuickStart -type BATCH

docker exec -ti PinotClimateAnalytics mkdir /tmp/pinot-storm-analytics

docker cp storm-events-table-config.json PinotClimateAnalytics:/tmp/pinot-storm-analytics
docker cp storm-events-schema.json PinotClimateAnalytics:/tmp/pinot-storm-analytics
docker cp storm-events-job-spec.yml PinotClimateAnalytics:/tmp/pinot-storm-analytics

docker cp ./rawdata "PinotClimateAnalytics:/tmp/pinot-storm-analytics/rawdata"

docker exec -ti PinotClimateAnalytics bin/pinot-admin.sh AddTable -tableConfigFile /tmp/pinot-storm-analytics/storm-events-table-config.json -schemaFile /tmp/pinot-storm-analytics/storm-events-schema.json -exec

docker exec -ti PinotClimateAnalytics bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/pinot-storm-analytics/storm-events-job-spec.yml
