SELECT subq0.c5 AS c7
FROM (SELECT 4 AS c5, t2.c2 AS c6
   FROM t0 AS t1
      CROSS JOIN t0 AS t2      
       ON (t1.c1 = t1.c0)
     LEFT OUTER JOIN t0 AS t3     
      ON (t1.c0 = t2.c1)
   WHERE t3.c1 <> t3.c1
   ORDER BY c6, c6 DESC, c6, c6 ASC) as subq0
WHERE COALESCE(subq0.c5, subq0.c5, subq0.c5, subq0.c6, subq0.c6, subq0.c6) <> subq0.c5
ORDER BY c7 ASC, c7 DESC, c7 DESC, c7;
