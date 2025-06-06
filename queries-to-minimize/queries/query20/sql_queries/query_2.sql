UPDATE t0 
SET c0 = t0.c0, c2 = t0.c2, c4 = t0.c4
WHERE t0.c3 = CAST(t0.c2 AS TEXT);
