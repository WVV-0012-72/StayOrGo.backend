-- get latest number of clients and thresholds for each acq fe
SELECT m.m_time, m.fe_name,
	c.c_position, c.c_radius,
	m.m_num_devices,
	CASE m.m_num_devices
		WHEN m.m_num_devices < c.c_threshold_y THEN "Go!"
		WHEN m.m_num_devices < c.c_threshold_r THEN "Try.. (<"||c.c_threshold_r||")"
		ELSE "Stay! (>"||c.c_threshold_r||")"
	END
FROM measurement m
INNER JOIN coverage c ON c.fe_name=m.fe_name
WHERE m.m_time=(SELECT max(t.m_time)
				FROM measurement t
				WHERE t.fe_name=m.fe_name)
ORDER BY m.m_time, m.fe_name;
