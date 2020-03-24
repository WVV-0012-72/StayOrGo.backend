#!/usr/bin/python
import sys
import time
import sqlite3
import dweepy

from influxdb import InfluxDBClient
from datetime import datetime

args = sys.argv
pibox = args[1]

# local SQLite management DB
db = sqlite3.connect('/path/to/management/stay_or_go.db')

# remove influxDB for measurements
idb_host = "95.179.161.77"
idb_port = "8086"
idb_user = "XXXXXX"
idb_pass = "XXXXXX"
idb_dbuser = "XXXXXX"
idb_dbpass = "XXXXXX"
idb_db = "stay_or_go"
idb = InfluxDBClient(idb_host, idb_port, idb_user, idb_pass, idb_db)
idb.switch_user(idb_dbuser, idb_dbpass)
# TODO: need proper retention policy


while True:
    try:
        dweets = dweepy.get_latest_dweet_for(pibox)
    except:
        print("dweet.io oops..")
        time.sleep(1)
        continue

    for dweet in dweets:
        # get dweet data
        d_thing = str(dweet['thing'])
        d_timestamp = str(dweet['created'])
        d_content = dweet['content']

        # extract frontend health status
        d_cputemp = str(d_content['cputemp']).replace("'","°")
        frontend =(d_thing, d_timestamp, d_cputemp)

        # extract measurement data
        m_time = datetime.utcfromtimestamp(d_content['unixtime']).isoformat() + 'Z'
        m_messages = d_content['messages']
        m_anzap = d_content['anzap']
        m_macs_area = d_content['macs_area']

        # TODO @ottmar: filter out *WEAK* clients. this parameter must be tunable from the BE


        # get location data and create corresponding measurements for this FE
        cur = db.cursor()
        cur.execute("SELECT * FROM location WHERE fe_name=?", (d_thing,))
        rows = cur.fetchall()
        for row in rows:
            # determine current SoG recommendation
            threshold_y = row[5];
            threshold_r = row[6];
            recommendation = "Stay!"
            if m_macs_area < threshold_r:
                recommendation = "Try.."
            if m_macs_area < threshold_y:
                recommendation = "Go!"

            # JSON object for influxDB
            crowd_size_measurement = [
                {
                    "measurement": "crowd_size",
                    "tags": {
                        "location_name": row[0],
                        "location_gps_lat": row[2],
                        "location_gps_lon": row[3],
                        "location_radius": row[4],
                        "threshold_yellow": threshold_y,
                        "threshold_red": threshold_r
                    },
                    "time": m_time,
                    "fields": {
                        "num_people": m_macs_area,
                        "recommendation": recommendation
                    }
                }
            ]
            # write to influxDB
            idb.write_points(crowd_size_measurement, time_precision='s')


            # TODO: need verbose mode for this
            print("+-------------------------------")
            print("| frontend: " + str(frontend))
            print("| measurement: " + str(crowd_size_measurement))

        time.sleep(1)

        continue


        # update frontend status
        # TODO: check that a frontend with fe_name exists, create in doubt
        try:
            fe_update= ("UPDATE frontend SET "
                "   fe_last_time='"+d_timestamp+"', "
                "   fe_cputemp='"+d_cputemp+"' "
                "WHERE fe_name='"+d_thing+"';")
            db.execute(fe_update);
        except:
            print("fe status update failed")


        # hush little baby, don't say a word.. :-)
        time.sleep(1)

db.close()








