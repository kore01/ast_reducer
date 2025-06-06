SELECT t_KVR.c_0g82YslPQP,
    t_KVR.c_4fLRz,
    SUM(CASE WHEN typeof(t_KVR.c_0g82YslPQP) IN ('integer', 'real', 'numeric') THEN t_KVR.c_0g82YslPQP ELSE 0 END) 
        OVER (PARTITION BY t_KVR.c_4fLRz) as window_total
FROM t_KVR
GROUP BY t_KVR.c_0g82YslPQP, t_KVR.c_4fLRz
HAVING SUM(CASE WHEN typeof(t_KVR.c_0g82YslPQP) IN ('integer', 'real', 'numeric') THEN t_KVR.c_0g82YslPQP ELSE 0 END) > 0
ORDER BY window_total DESC
LIMIT 10;
