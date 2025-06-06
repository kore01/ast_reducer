SELECT 
 CASE WHEN subq0.c14 < subq0.c6 AND subq0.c18 <> subq0.c18 AND subq0.c9 >= 2 THEN subq0.c11
      ELSE subq0.c13
 END AS c17, subq0.c16 AS c18, subq0.c5 AS c19, subq0.c7 AS c20, subq0.c16 AS c21, subq0.c21 AS c22, subq0.c21 AS c23
FROM (SELECT t1.c0 AS c5, t1.c4 AS c6, t1.c2 AS c7, t1.c1 AS c8, IFNULL(t1.c3, t1.c3) AS c9, t1.c1 AS c10, t1.c0 AS c11, t1.c3 AS c12, t1.c4 AS c13, ltrim( FALSE) AS c14, t1.c4 AS c15, t1.c3 AS c16, NULLIF(t1.c0, t1.c0) AS c17, t1.c1 AS c18, t1.c4 AS c19, t1.c2 AS c20, t1.c2 AS c21, 
    CASE WHEN t1.c0 = t1.c0 THEN t1.c1
         ELSE t1.c0
    END AS c22, 
    CASE t1.c2 WHEN t1.c1 <> t1.c1 THEN t1.c2
         WHEN likelihood(NULL,0.097802) > t1.c2 THEN t1.c2
         WHEN t1.c3 = t1.c3 THEN t1.c2
         WHEN t1.c4 = t1.c4 THEN t1.c2
         WHEN t1.c3 <> t1.c3 THEN t1.c2
         WHEN EXISTS (
     SELECT t2.c2 AS c5, t2.c4 AS c6, t2.c4 AS c7
      FROM t0 AS t2
        LEFT JOIN t0 AS t3        
         ON (t2.c2 = t3.c2)
      WHERE t2.c1 <> t2.c1
      ORDER BY c6 DESC, c6 DESC
      LIMIT 7262358248999388677 
     ) OR 
     CASE WHEN t1.c4 >= t1.c4 AND NULL IS NULL THEN t1.c3
          ELSE NULL
     END = t1.c3 THEN t1.c2
         WHEN EXISTS (
     SELECT t4.c2 AS c5, t4.c1 AS c6, t4.c1 AS c7, t4.c0 AS c8
      FROM t0 AS t4
      WHERE true
      ORDER BY c5, c7
      LIMIT 3084467557702557815 OFFSET 4908473048124723401
     ) THEN t1.c2
         WHEN CAST(t1.c1 AS TEXT) = 'text42' THEN t1.c2
         WHEN t1.c2 > t1.c2 AND t1.c0 IS NULL THEN t1.c2
         ELSE t1.c2
    END AS c9, t1.c3 AS c10, t1.c4 AS c11, t1.c2 AS c12, t1.c1 AS c13, t1.c0 AS c14, t1.c3 AS c15, t1.c4 AS c16
   FROM t0 AS t1
   WHERE t1.c0 <> t1.c0
   ORDER BY c11 DESC
   LIMIT 906032125336520990 ) as subq0
WHERE false AND substr(TRUE,'text68') < ifnull(TRUE,35) AND true
ORDER BY c20 DESC;
