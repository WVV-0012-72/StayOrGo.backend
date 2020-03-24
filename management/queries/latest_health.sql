SELECT f.fe_last_time, f.fe_name, f.fe_cputemp
FROM frontend f
WHERE f.fe_last_time=(SELECT max(t.fe_last_time) FROM frontend t WHERE t.fe_name=m.fe_name)
ORDER BY f.fe_name
