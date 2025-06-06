SELECT subq0.c7 AS c12, 27 AS c13, 
 CASE WHEN subq0.c10 <> subq0.c11 AND 55 = subq0.c7 AND subq0.c8 >= subq0.c7 THEN like(37,NULL,'񀅂')
      ELSE subq0.c8
 END AS c14
FROM (SELECT t4.c5 AS c7, t4.c1 AS c8, t2.c6 AS c9, t3.c2 AS c10, t4.c6 AS c11
   FROM t0 AS t1
     LEFT JOIN (
     t0 AS t2
      LEFT JOIN (
      t0 AS t3
       LEFT OUTER JOIN t0 AS t4       
        ON (t3.c4 <> t4.c4)      )
       ON (t3.c3 > t3.c3 AND t2.c3 >= t2.c3)     )
      ON (t1.c5 IS NULL AND false)
   WHERE 'text67' < t4.c3
   ORDER BY c11, c7 DESC, c7
   LIMIT 3888967397801250598 OFFSET 1510394422900618475) as subq0
WHERE false
ORDER BY c14 DESC, c12, c12 COLLATE BINARY DESC
LIMIT 7555288326383950501 OFFSET 349165599566047263;
