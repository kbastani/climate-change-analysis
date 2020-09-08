# Climate Change Analytics

This repository contains a recipe for bootstrapping a climate analysis application using Apache Pinot and Superset.

## Usage

The example application in this repository bootstraps an Apache Pinot recipe for importing NOAA storm event data for analysis with Apache Superset.

To start the cluster, run the following commands.

```bash
$ docker network create PinotNetwork
$ docker-compose up -d
$ docker-compose logs -f --tail=100
```

After the Docker containers have started and are running, you'll need to bootstrap the cluster with the NOAA storm data and charts. The following command will download the raw data from NOAA's storm events FTP server and begin the Pinot ingestion job.

```bash
$ sh ./bootstrap.sh
```

After the bootstrap script has completed, you should be able to see data in Apache Pinot and be able to login to the Superset website. After logging into Superset, navigate to the dashboards to view the NOAA storm event map in the United States.
