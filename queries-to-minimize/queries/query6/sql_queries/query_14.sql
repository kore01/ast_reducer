SELECT COALESCE(subq0.c7, subq0.c8) AS c10
FROM (SELECT t3.c6 AS c7, t3.c6 AS c8, t3.c2 AS c9
   FROM t0 AS t1
      LEFT OUTER JOIN t0 AS t2      
       ON (t1.c1 >= t2.c1)
     INNER JOIN t0 AS t3     
      ON (t3.c3 < t1.c3)
   WHERE t2.c4 IS NOT NULL
   ORDER BY c9 COLLATE BINARY, c7, c9
   LIMIT 8872177644813134736 ) as subq0
WHERE 
 CASE WHEN subq0.c8 = subq0.c8 THEN subq0.c8
      ELSE subq0.c9
 END = 
 CASE WHEN subq0.c8 = subq0.c9 AND subq0.c9 <> subq0.c8 AND 
  CASE WHEN subq0.c8 = COALESCE(subq0.c9, subq0.c9) THEN subq0.c8
       ELSE subq0.c9
  END = CAST(subq0.c7 AS TEXT) THEN subq0.c7
      ELSE subq0.c9
 END
ORDER BY c10 DESC;
