SELECT DISTINCT t_KVR.c_0g82YslPQP,
    COUNT(*) OVER (PARTITION BY t_KVR.c_4fLRz) as window_count,
    RANK() OVER (ORDER BY CASE WHEN typeof(t_KVR.c_0g82YslPQP) IN ('null') THEN 0 
                            ELSE t_KVR.c_0g82YslPQP END DESC) as rank_val,
    CASE WHEN t_KVR.c_0g82YslPQP IS NULL THEN 'Unknown' ELSE 'Known' END as status
FROM t_KVR
WHERE t_KVR.c_0g82YslPQP IS NOT NULL
GROUP BY t_KVR.c_0g82YslPQP, t_KVR.c_4fLRz
HAVING COUNT(*) > 0
ORDER BY window_count DESC
LIMIT 20;
