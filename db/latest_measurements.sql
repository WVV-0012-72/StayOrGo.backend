-- get latest number of clients and thresholds for each acq fe
SELECT m.m_time, m.fe_name, m.m_num_devices, c.c_threshold_y, c.c_threshold_r
FROM measurement m
INNER JOIN coverage c ON c.fe_name=m.fe_name
WHERE m.m_time=(SELECT max(t.m_time) FROM measurement t WHERE t.fe_name=m.fe_name)
ORDER BY m.m_time, m.fe_name;
