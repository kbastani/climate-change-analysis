#!/bin/bash

# Imports NOAA storm event data into Apache Pinot
docker exec -ti pinot_app_noaa bash -c "sh ./import/import-storm-events.sh"

# Initializes the Superset application and imports datasources and dashboards
docker exec -ti -u root superset_app_noaa bash -c "sh ./docker-init.sh"

# Open the browser for Pinot and Superset
open http://localhost:9000
open http://localhost:8088

echo "Success! Login to Superset using the credentials admin/admin"
