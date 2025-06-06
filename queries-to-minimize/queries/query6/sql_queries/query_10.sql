SELECT subq0.c8 AS c7, t3.c4 AS c8, subq0.c11 AS c9, 
 CASE t3.c1 WHEN subq0.c15 = IFNULL(t3.c6, 
   CASE WHEN max(94,TRUE,FALSE) IS NOT NULL THEN subq0.c9
        ELSE subq0.c9
   END) THEN t3.c1
      WHEN CAST(subq0.c8 AS INTEGER) = subq0.c15 THEN t3.c5
      WHEN subq0.c15 <> t3.c2 THEN subq0.c14
      WHEN subq0.c12 = t3.c3 THEN subq0.c11
      WHEN false OR t3.c2 = TRUE THEN t3.c1
      WHEN FALSE IS NULL OR t3.c0 IS NULL OR EXISTS (
  SELECT t4.c0 AS c7, COALESCE(
     CASE t4.c3 WHEN EXISTS (
      SELECT t5.c2 AS c7, t5.c5 AS c8, t5.c3 AS c9, t5.c4 AS c10, t5.c6 AS c11, t5.c3 AS c12, 'text26' AS c13, t5.c0 AS c14, t5.c3 AS c15, t5.c6 AS c16, t5.c1 AS c17, t5.c3 AS c18, t5.c4 AS c19
       FROM t0 AS t5
       WHERE t5.c2 <> t5.c6
       ORDER BY c11
       LIMIT 8367844154338802670 OFFSET 4897869847856910543
      ) THEN t4.c4
          WHEN true THEN t4.c3
          WHEN t4.c6 = t4.c0 OR t4.c1 = t4.c5 THEN t4.c0
          WHEN t4.c0 <> t4.c2 THEN t4.c0
          WHEN t4.c3 = t4.c3 AND t4.c6 IS NOT NULL THEN t4.c1
          WHEN 8 > t4.c1 THEN t4.c2
          WHEN t4.c5 IS NOT NULL THEN t4.c3
          ELSE t4.c0
     END, t4.c4, t4.c1, t4.c1, t4.c5) AS c20, t4.c0 AS c21, 'text83' AS c22, t4.c5 AS c23, t4.c1 AS c24, t4.c5 AS c25, t4.c2 AS c26, t4.c6 AS c27, t4.c4 AS c28, t4.c4 AS c29, t4.c2 AS c30
   FROM t0 AS t4
   WHERE EXISTS (
    SELECT t6.c1 AS c7, t6.c6 AS c8, t6.c1 AS c9, t6.c0 AS c10, t6.c5 AS c11, t6.c5 AS c12, t6.c4 AS c13, t6.c2 AS c14, t6.c1 AS c15, t6.c5 AS c16, t6.c3 AS c17, t6.c5 AS c18
     FROM t0 AS t6
     WHERE t6.c0 = t6.c0
     ORDER BY c9 COLLATE NOCASE ASC
     LIMIT 5928330123659345534 OFFSET 1119749379068271269
    )
   ORDER BY c24, c7 ASC, c22 DESC
  ) AND 
  CASE WHEN t3.c2 IS NOT NULL THEN subq0.c10
       ELSE subq0.c10
  END IS NOT NULL OR subq0.c17 IS NOT NULL OR subq0.c8 <> subq0.c8 AND subq0.c16 <> subq0.c16 AND 56 >= t3.c1 THEN subq0.c11
      WHEN t3.c1 >= CAST(subq0.c16 AS INTEGER) THEN subq0.c17
      WHEN like('text4',TRUE) IS NULL THEN t3.c1
      ELSE subq0.c17
 END AS c19, t3.c3 AS c20, subq0.c7 AS c21, FALSE AS c22, subq0.c9 AS c23, 
 CASE WHEN subq0.c14 IS NULL THEN subq0.c15
      ELSE subq0.c13
 END AS c24, FALSE AS c25, subq0.c15 AS c26, 
 CASE WHEN NULL <> t3.c4 THEN subq0.c16
      ELSE NULL
 END AS c27, subq0.c16 AS c28, t3.c3 AS c29, subq0.c17 AS c30, subq0.c16 AS c31, subq0.c8 AS c32, subq0.c8 AS c33
FROM (SELECT t1.c3 AS c7, t1.c5 AS c8, t1.c6 AS c9, t1.c0 AS c10, t1.c5 AS c11, t1.c3 AS c12, t1.c2 AS c13, t1.c1 AS c14, t1.c0 AS c15, t1.c4 AS c16, t1.c5 AS c17
    FROM t0 AS t1
    WHERE EXISTS (
     SELECT t2.c0 AS c7, t2.c4 AS c8, t2.c3 AS c9, t2.c5 AS c10
      FROM t0 AS t2
      WHERE t2.c3 < t2.c3
      ORDER BY c8 DESC, c7
      LIMIT 8487782910337437069 OFFSET 8940054953469969540
     )
    ORDER BY c14 ASC, c15 ASC
    LIMIT 5241486417947844697 ) as subq0
  LEFT JOIN t0 AS t3  
   ON (t3.c5 IS NULL)
WHERE false
ORDER BY c32 ASC;
