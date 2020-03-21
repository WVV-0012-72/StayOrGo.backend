# StayOrGo backend

WRITEME

# Requirements
* Linux
* Python3
  * Dweepy (pip install dweepy)

# Usage
## setup database
$ ./setup_db.sh

## start acquisitoin frontend connector
$ ./ottmar.wifi.py pi-box-02
$ ./ottmar.wifi.py pi-box-04

## ...

## Profit
get latest measurements including thresholds for yellow/red:
$ ./db/latest_measurements.sql
