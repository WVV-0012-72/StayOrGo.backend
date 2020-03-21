#!/usr/bin/python
import sys
import time
import sqlite3
import dweepy


args = sys.argv
pibox = args[1]

db = sqlite3.connect('stay_or_go.db')


while True:
    dweets = dweepy.get_latest_dweet_for(pibox)
    for dweet in dweets:
        # get dweet data
        d_thing = str(dweet['thing'])
        d_timestamp = str(dweet['created'])
        d_content = dweet['content']

        # extract frontend health status
        d_cputemp = str(d_content['cputemp']).replace("'","°")
        frontend =(d_thing, d_timestamp, d_cputemp)

        # extract measurement data
        m_time = d_content['time']
        m_messages = d_content['messages']
        m_anzap = d_content['anzap']
        m_macs_area = d_content['macs_area']
        measurement =(d_thing, m_time, m_anzap, (m_macs_area-m_anzap))


        # TODO: need verbose mode for this
        print("+-------------------------------")
        print("| frontend: " + str(frontend))
        print("| measurement: " + str(measurement))


        # update frontend status
        # TODO: check that a frontend with fe_name exists, create in doubt
        fe_update= ("UPDATE frontend SET "
            "   fe_last_time='"+d_timestamp+"', "
            "   fe_cputemp='"+d_cputemp+"' "
            "WHERE fe_name='"+d_thing+"';")
        db.execute(fe_update);


        # write measurement into database
        db.execute("INSERT INTO measurement VALUES(?, ?, ?, ?)", measurement)
        db.commit()

        # hush little baby, don't say a word.. :-)
        time.sleep(2)

db.close()
