SELECT t_EiJ.c_6C2xHrvsC,
    t_EiJ.c_Le8nWz,
    SUM(CASE WHEN typeof(t_EiJ.c_6C2xHrvsC) IN ('integer', 'real', 'numeric') THEN t_EiJ.c_6C2xHrvsC ELSE 0 END) 
        OVER (PARTITION BY t_EiJ.c_Le8nWz) as window_total
FROM t_EiJ
GROUP BY t_EiJ.c_6C2xHrvsC, t_EiJ.c_Le8nWz
HAVING SUM(CASE WHEN typeof(t_EiJ.c_6C2xHrvsC) IN ('integer', 'real', 'numeric') THEN t_EiJ.c_6C2xHrvsC ELSE 0 END) > 0
ORDER BY window_total DESC
LIMIT 10;
