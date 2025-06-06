SELECT subq1.c8 AS c5, t5.c1 AS c6, FALSE AS c7, t4.c0 AS c8, t4.c4 AS c9, t4.c2 AS c10, 
 CASE WHEN subq0.c5 IS NOT NULL THEN subq1.c8
      ELSE t4.c3
 END AS c11, t4.c3 AS c12
FROM (SELECT t1.c2 AS c5, t1.c0 AS c6
    FROM t0 AS t1
    WHERE t1.c1 = t1.c0 OR t1.c0 <> t1.c0 OR true OR t1.c1 <> t1.c0 OR t1.c3 <> t1.c3 OR COALESCE(t1.c3, t1.c3, t1.c2, t1.c2, t1.c3) <> t1.c2
    ORDER BY c6 COLLATE RTRIM ASC
    LIMIT 1566526972627615022 OFFSET 755997179622966651) as subq0
  INNER JOIN (
  (SELECT t3.c1 AS c5, t3.c1 AS c6, t2.c4 AS c7, t3.c3 AS c8, t2.c3 AS c9, t3.c1 AS c10, t3.c1 AS c11, t2.c0 AS c12, t3.c0 AS c13, t2.c4 AS c14
      FROM t0 AS t2
        INNER JOIN t0 AS t3        
         ON (t3.c3 <> t3.c3)
      WHERE t2.c0 <> t3.c0 OR t2.c4 >= t3.c4 AND t3.c1 = t3.c1 OR t2.c0 <> t2.c0 AND t3.c3 = t2.c3 OR true
      ORDER BY c5, c5) as subq1
    LEFT JOIN t0 AS t4    
     ON (subq1.c14 = t4.c4)
   LEFT JOIN t0 AS t5   
    ON (t4.c1 <> FALSE)  )
   ON (subq1.c5 <> subq1.c12)
WHERE true
ORDER BY c6 COLLATE BINARY
LIMIT 8657018412999196054;
