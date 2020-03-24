# StayOrGo.backend
This is the StayOrGo backend repository.

The backend comprises of essentially three parts:
* ingestion
* management
* influxDB

## Requirements
* Linux
* Python3
* Dweepy (pip install dweepy)
* InfluxDB


## data ingestion
### ottmar.wifi
$ ./ottmar.wifi.py pi-box-02
$ ./ottmar.wifi.py pi-box-04

## backend management
### setup management database
$ ./setup_db.sh

## influxDB
[WRITEME]

essentially we just push data there and do semi-intelligent queries

## Profit
get latest measurements including thresholds for yellow/red:

$ ./db/latest_measurements.sql

[FIXME] OUTDATED WITH INFLUXDB]
