UPDATE t0 
SET c0 = t0.c0, c3 = upper( 77), c4 = t0.c4
WHERE 
 CASE t0.c3 WHEN t0.c1 >= t0.c5 THEN t0.c3
      WHEN t0.c1 >= t0.c1 THEN t0.c3
      WHEN EXISTS (
  SELECT t2.c4 AS c7, t2.c2 AS c8, t1.c2 AS c9, NULL AS c10, t1.c0 AS c11, t1.c6 AS c12, t1.c4 AS c13
   FROM t0 AS t1
     LEFT JOIN t0 AS t2     
      ON (t1.c4 <> t2.c4)
   WHERE EXISTS (
    SELECT t3.c4 AS c7, t3.c3 AS c8, t3.c2 AS c9, t3.c3 AS c10, t3.c0 AS c11, t3.c4 AS c12, t3.c3 AS c13
     FROM t0 AS t3
     WHERE EXISTS (
      SELECT t4.c5 AS c7, t4.c6 AS c8, t4.c2 AS c9, t4.c1 AS c10, t4.c4 AS c11, t4.c1 AS c12
       FROM t0 AS t4
       WHERE t4.c5 > 91 AND t4.c4 IS NOT NULL OR 46 <= t4.c1
       ORDER BY c11 ASC, c9, c12 ASC
      )
     ORDER BY c9, c8 ASC
    )
   ORDER BY c13, c10
  ) THEN quote( TRUE)
      WHEN t0.c2 <> t0.c0 THEN t0.c3
      WHEN t0.c0 <> t0.c2 AND t0.c4 = t0.c4 AND t0.c5 IS NULL OR 
  CASE t0.c0 WHEN t0.c2 <> t0.c6 THEN t0.c0
       WHEN COALESCE(t0.c4, t0.c2, t0.c4, t0.c6) <> t0.c2 THEN t0.c6
       WHEN t0.c4 = COALESCE(t0.c4, t0.c4, t0.c0, t0.c4, t0.c4) THEN t0.c6
       WHEN EXISTS (
   SELECT t5.c3 AS c7, t7.c4 AS c8, t7.c2 AS c9, t6.c2 AS c10, t5.c3 AS c11, t6.c3 AS c12
    FROM t0 AS t5
      INNER JOIN (
      t0 AS t6
       LEFT JOIN t0 AS t7       
        ON (t6.c3 = t7.c3)      )
       ON (t7.c0 IS NOT NULL AND t5.c5 <= t5.c5)
    WHERE t6.c1 = t7.c5 OR t7.c5 = 61 OR false OR FALSE <> t5.c2
    ORDER BY c7 ASC
   ) AND t0.c1 > t0.c5 OR t0.c5 <= t0.c5 AND t0.c6 IS NULL THEN t0.c0
       WHEN t0.c6 <> t0.c6 THEN t0.c0
       WHEN t0.c2 <> t0.c0 AND false AND 
   CASE WHEN t0.c3 >= t0.c3 THEN t0.c2
        ELSE FALSE
   END = t0.c2 OR EXISTS (
   SELECT t8.c4 AS c7, t8.c5 AS c8, t8.c0 AS c9, t8.c0 AS c10, t8.c1 AS c11, 59 AS c12, t8.c4 AS c13, t8.c1 AS c14, FALSE AS c15, t8.c2 AS c16
    FROM t0 AS t8
    WHERE t8.c6 = FALSE OR t8.c0 = t8.c0
    ORDER BY c8, c14 COLLATE NOCASE DESC, c9 COLLATE NOCASE
    LIMIT 4633730287411729534 
   ) OR NULLIF(t0.c5, t0.c1) <= t0.c5 THEN t0.c2
       WHEN t0.c0 <> t0.c0 THEN t0.c2
       WHEN t0.c2 <> t0.c6 OR t0.c0 IS NOT NULL AND EXISTS (
   SELECT t9.c5 AS c7, t9.c3 AS c8, t9.c0 AS c9, t9.c2 AS c10, t9.c2 AS c11, t9.c6 AS c12, t9.c4 AS c13, t9.c5 AS c14, t9.c3 AS c15, t9.c6 AS c16, t9.c5 AS c17, t9.c5 AS c18, t9.c2 AS c19, t9.c4 AS c20, t9.c2 AS c21, t9.c5 AS c22, TRUE AS c23, NULLIF(t9.c4, t9.c4) AS c24
    FROM t0 AS t9
    WHERE t9.c0 = t9.c6
    ORDER BY c10, c15, c17 ASC
   ) THEN 
   CASE WHEN false THEN t0.c2
        ELSE t0.c6
   END
       ELSE t0.c2
  END = 
  CASE WHEN 
   CASE WHEN t0.c2 <> FALSE THEN t0.c6
        ELSE trim( 'text11')
   END IS NULL THEN 
   CASE WHEN true THEN t0.c6
        ELSE t0.c6
   END
       ELSE IFNULL(t0.c6, t0.c0)
  END AND false AND t0.c5 >= t0.c1 THEN t0.c3
      WHEN t0.c3 >= t0.c3 AND length( FALSE) <= IFNULL(t0.c1, t0.c1) THEN COALESCE(t0.c4, t0.c4)
      WHEN EXISTS (
  SELECT t12.c2 AS c7, t10.c6 AS c8, t11.c1 AS c9, t12.c1 AS c10, 
    CASE t12.c4 WHEN t11.c5 > t10.c5 THEN t11.c4
         ELSE t10.c4
    END AS c11, NULLIF(t11.c4, t10.c4) AS c12, t12.c6 AS c13, t11.c5 AS c14, CAST(t12.c2 AS BOOLEAN) AS c15, t11.c3 AS c16, NULLIF(t12.c3, t10.c3) AS c17, t12.c3 AS c18, t12.c6 AS c19
   FROM t0 AS t10
     LEFT JOIN (
     t0 AS t11
      LEFT JOIN t0 AS t12      
       ON (t12.c4 IS NOT NULL)     )
      ON (t10.c1 = t11.c1)
   WHERE false
   ORDER BY c16 DESC, c19 DESC
   LIMIT 6435163214005728455 OFFSET 8629639050956326708
  ) OR t0.c1 IS NULL THEN t0.c3
      WHEN t0.c6 <> t0.c6 THEN t0.c3
      ELSE t0.c3
 END < t0.c3;
