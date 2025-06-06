SELECT DISTINCT t_EiJ.c_6C2xHrvsC,
    COUNT(*) OVER (PARTITION BY t_EiJ.c_Le8nWz) as window_count,
    RANK() OVER (ORDER BY CASE WHEN typeof(t_EiJ.c_6C2xHrvsC) IN ('null') THEN 0 
                            ELSE t_EiJ.c_6C2xHrvsC END DESC) as rank_val,
    CASE WHEN t_EiJ.c_6C2xHrvsC IS NULL THEN 'Unknown' ELSE 'Known' END as status
FROM t_EiJ
WHERE t_EiJ.c_6C2xHrvsC IS NOT NULL
GROUP BY t_EiJ.c_6C2xHrvsC, t_EiJ.c_Le8nWz
HAVING COUNT(*) > 0
ORDER BY window_count DESC
LIMIT 20;
