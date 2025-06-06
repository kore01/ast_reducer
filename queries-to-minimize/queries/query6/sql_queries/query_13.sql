SELECT subq0.c14 AS c11
FROM (SELECT t1.c5 AS c7, t1.c4 AS c8, 96 AS c9, 
    CASE t1.c6 WHEN t1.c6 = t1.c2 THEN t1.c6
         WHEN t1.c3 >= t1.c3 AND t1.c3 <= t1.c3 OR EXISTS (
     SELECT t2.c1 AS c7, t2.c3 AS c8, t2.c1 AS c9
      FROM t0 AS t2
      WHERE t2.c2 IS NOT NULL
      ORDER BY c8, c9, c8
      LIMIT 8073623243054982113 
     ) THEN t1.c2
         WHEN t1.c5 = t1.c1 THEN t1.c0
         ELSE 
     CASE WHEN false THEN t1.c0
          ELSE t1.c0
     END
    END AS c10, t1.c3 AS c11, t1.c3 AS c12, t1.c3 AS c13, COALESCE(t1.c1, t1.c4) AS c14, t1.c4 AS c15
   FROM t0 AS t1
   WHERE t1.c6 = t1.c0 AND t1.c2 <> t1.c2 OR t1.c2 = 
    CASE t1.c0 WHEN EXISTS (
     SELECT 5 AS c7, t3.c2 AS c8, t3.c3 AS c9, TRUE AS c10
      FROM t0 AS t3
      WHERE t3.c5 <> t3.c1
      ORDER BY c8, c8 DESC, c10
     ) THEN t1.c2
         WHEN t1.c5 >= t1.c1 THEN t1.c2
         WHEN t1.c0 <> t1.c6 THEN t1.c6
         ELSE t1.c2
    END
   ORDER BY c10, c11 ASC) as subq0
WHERE EXISTS (
 SELECT subq1.c8 AS c11, subq1.c8 AS c12, subq2.c10 AS c13, subq2.c9 AS c14, subq2.c8 AS c15
  FROM (SELECT t4.c3 AS c7, t4.c4 AS c8
      FROM t0 AS t4
      WHERE t4.c6 = t4.c0 AND 28 < t4.c1
      ORDER BY c8 COLLATE BINARY
      LIMIT 4537694807183241409 ) as subq1
    LEFT JOIN (SELECT t5.c4 AS c7, t5.c3 AS c8, t5.c4 AS c9, t5.c0 AS c10
      FROM t0 AS t5
      WHERE t5.c1 IS NOT NULL
      ORDER BY c9) as subq2    
     ON (subq2.c9 = subq2.c7)
  WHERE subq2.c8 = subq2.c8
  ORDER BY c11 COLLATE RTRIM
  LIMIT 8121752498674788175 OFFSET 1590141587996445005
 ) AND subq0.c12 <> subq0.c13
ORDER BY c11, c11, c11 DESC, c11 COLLATE BINARY ASC
LIMIT 5264995973287149286 OFFSET 5022098690157832144;
