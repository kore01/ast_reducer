SELECT subq0.c6 AS c9, subq0.c8 AS c10, 
 CASE subq0.c7 WHEN false OR 
  CASE WHEN subq0.c7 <> subq0.c8 THEN 
   CASE WHEN subq0.c7 = subq0.c6 THEN subq0.c5
        ELSE subq0.c8
   END
       ELSE subq0.c5
  END IS NULL AND subq0.c6 <> subq0.c8 AND subq0.c5 < subq0.c5 THEN FALSE
      WHEN subq0.c5 <> 55 THEN subq0.c8
      WHEN 
  CASE WHEN NULLIF(subq0.c7, like('text34',FALSE)) IS NOT NULL THEN subq0.c6
       ELSE subq0.c8
  END = subq0.c8 AND subq0.c8 = subq0.c6 THEN subq0.c6
      WHEN subq0.c7 <> subq0.c6 THEN subq0.c7
      WHEN 
  CASE WHEN EXISTS (
   SELECT t4.c1 AS c5, t4.c4 AS c6, 
     CASE t4.c1 WHEN TRUE = t4.c0 THEN t4.c1
          WHEN TRUE <> t4.c1 THEN t4.c1
          WHEN t4.c3 <> t4.c3 THEN t4.c1
          ELSE t4.c1
     END AS c7, t4.c1 AS c8, t4.c1 AS c9
    FROM t0 AS t4
    WHERE t4.c0 <> t4.c0
    ORDER BY c5 DESC
    LIMIT 1280513665834716451 OFFSET 581408224666032018
   ) OR subq0.c8 = subq0.c8 AND subq0.c7 <> subq0.c8 AND subq0.c7 <> subq0.c8 THEN subq0.c6
       ELSE subq0.c8
  END <> subq0.c8 THEN subq0.c8
      WHEN EXISTS (
  SELECT t5.c3 AS c5, t5.c3 AS c6, t5.c0 AS c7, NULLIF(t5.c2, t5.c2) AS c8, t5.c4 AS c9, t5.c3 AS c10, t5.c0 AS c11, t5.c2 AS c12, t5.c4 AS c13, t5.c1 AS c14
   FROM t0 AS t5
   WHERE t5.c0 <> 
    CASE t5.c1 WHEN t5.c1 = t5.c0 THEN t5.c1
         WHEN t5.c2 <> t5.c2 THEN t5.c0
         WHEN t5.c0 = t5.c0 THEN t5.c0
         WHEN t5.c2 >= t5.c2 THEN t5.c0
         WHEN true THEN 
     CASE WHEN t5.c0 = CAST(t5.c1 AS INTEGER) THEN t5.c0
          ELSE t5.c0
     END
         WHEN t5.c1 <> t5.c1 OR t5.c3 <> t5.c3 AND true THEN t5.c1
         WHEN rtrim('text23',33) IS NOT NULL OR true THEN t5.c0
         ELSE t5.c1
    END
   ORDER BY c7, c6 ASC
   LIMIT 3906188417417659812 OFFSET 3986198644048307224
  ) THEN subq0.c7
      WHEN CAST(subq0.c8 AS BOOLEAN) IS NULL THEN subq0.c6
      WHEN COALESCE(subq0.c6, CAST(subq0.c5 AS TEXT), subq0.c7, subq0.c8, CAST(glob(5,NULL) AS TEXT), round('text72',TRUE)) <> subq0.c8 THEN subq0.c8
      WHEN subq0.c8 IS NULL AND subq0.c7 = CAST(subq0.c7 AS BOOLEAN) AND subq0.c6 <> TRUE THEN subq0.c7
      WHEN subq0.c7 <> subq0.c7 THEN subq0.c6
      WHEN subq0.c5 > subq0.c5 THEN subq0.c8
      WHEN subq0.c6 <> subq0.c8 OR subq0.c5 >= subq0.c5 THEN subq0.c8
      ELSE subq0.c6
 END AS c15, subq0.c8 AS c16, 
 CASE WHEN EXISTS (
  SELECT 
    CASE WHEN t8.c1 IS NULL AND t8.c2 > t9.c2 THEN t9.c4
         ELSE t7.c4
    END AS c29, t8.c3 AS c30, t6.c0 AS c31, t8.c3 AS c32, t7.c0 AS c33, t9.c2 AS c34, t6.c3 AS c35, t7.c3 AS c36, t9.c4 AS c37, t9.c3 AS c38, t7.c0 AS c39, t9.c2 AS c40, t9.c3 AS c41, t6.c0 AS c42, t7.c3 AS c43, t9.c1 AS c44, t8.c0 AS c45, t7.c1 AS c46
   FROM t0 AS t6
     LEFT OUTER JOIN (
     t0 AS t7
      INNER JOIN (
      t0 AS t8
       CROSS JOIN t0 AS t9       
        ON (t9.c3 = t8.c3)      )
       ON (t8.c0 = t8.c1 OR EXISTS (
        SELECT t10.c1 AS c5, t10.c3 AS c6, t10.c3 AS c7
         FROM t0 AS t10
         WHERE true
         ORDER BY c7 ASC, c7, c6 DESC
        ))     )
      ON (t7.c1 = t7.c0 OR EXISTS (
       SELECT ALL t11.c0 AS c5, t11.c4 AS c6, t11.c2 AS c7, t11.c3 AS c8, t11.c0 AS c9, t11.c2 AS c10, t11.c3 AS c11, t11.c0 AS c12, t11.c2 AS c13, t11.c4 AS c14, t11.c0 AS c15, t11.c1 AS c16, t11.c1 AS c17, t11.c4 AS c18, t11.c3 AS c19, t11.c4 AS c20, t11.c0 AS c21, t11.c1 AS c22, t11.c3 AS c23, t11.c3 AS c24, t11.c3 AS c25, t11.c4 AS c26, t11.c0 AS c27, t11.c4 AS c28
        FROM t0 AS t11
        WHERE t11.c0 <> t11.c1 AND t11.c3 <> t11.c3
        ORDER BY c13, c21 COLLATE BINARY DESC, c13 DESC
        LIMIT 4666398613485326882 
       ))
   WHERE like(FALSE,NULL) IS NULL OR t8.c0 = FALSE
   ORDER BY c40, c46, c30 COLLATE NOCASE ASC
   LIMIT 2892024916826749180 OFFSET 2346044335106521994
  ) AND EXISTS (
  SELECT t12.c3 AS c5, t12.c0 AS c6
   FROM t0 AS t12
     INNER JOIN (
     t0 AS t13
      INNER JOIN t0 AS t14      
       ON (t13.c4 IS NOT NULL)     )
      ON (t13.c2 <> t12.c2)
   WHERE t12.c4 IS NULL AND t14.c1 IS NOT NULL
   ORDER BY c6
   LIMIT 1577224672905552195 OFFSET 3800345213815333165
  ) THEN subq0.c8
      ELSE subq0.c6
 END AS c7, subq0.c5 AS c8, subq0.c8 AS c9, subq0.c6 AS c10, subq0.c7 AS c11, subq0.c8 AS c12, 
 CASE WHEN subq0.c6 IS NULL THEN NULLIF(subq0.c6, subq0.c6)
      ELSE subq0.c7
 END AS c13, 
 CASE WHEN CAST(subq0.c6 AS INTEGER) = CAST(subq0.c5 AS INTEGER) THEN subq0.c5
      ELSE subq0.c5
 END AS c14, subq0.c6 AS c15, subq0.c6 AS c16, subq0.c8 AS c17, subq0.c6 AS c18, subq0.c8 AS c19, subq0.c8 AS c20, subq0.c7 AS c21
FROM (SELECT t3.c2 AS c5, t3.c0 AS c6, t3.c0 AS c7, t2.c0 AS c8
   FROM t0 AS t1
      LEFT OUTER JOIN t0 AS t2      
       ON (t1.c1 = t2.c0)
     LEFT JOIN t0 AS t3     
      ON (true)
   WHERE t2.c1 = t3.c1
   ORDER BY c7, c8 COLLATE RTRIM ASC, c6
   LIMIT 8442260309220876271 OFFSET 3822454569420395662) as subq0
WHERE EXISTS (
 SELECT t16.c4 AS c5, t16.c0 AS c6, t17.c3 AS c7, t16.c0 AS c8, t16.c1 AS c9, t15.c0 AS c10, t16.c1 AS c11, t16.c3 AS c12, t15.c1 AS c13, t17.c3 AS c14
  FROM t0 AS t15
    INNER JOIN (
    t0 AS t16
     INNER JOIN t0 AS t17     
      ON (t16.c2 = t17.c2)    )
     ON (TRUE <> t15.c1 OR t16.c1 = t16.c1 OR t16.c3 = t16.c3)
  WHERE EXISTS (
   SELECT t18.c4 AS c5, t18.c3 AS c6, t18.c3 AS c7, t18.c2 AS c8, t18.c2 AS c9, t18.c1 AS c10, t18.c3 AS c11, 4 AS c12, t18.c3 AS c13, t18.c0 AS c14, t18.c4 AS c15, t18.c3 AS c16, t18.c3 AS c17, t18.c2 AS c18
    FROM t0 AS t18
    WHERE t18.c0 = 
     CASE WHEN false THEN t18.c0
          ELSE t18.c0
     END
    ORDER BY c15 DESC, c6
   )
  ORDER BY c8 DESC
 ) AND subq0.c5 IS NULL AND subq0.c6 IS NOT NULL
ORDER BY c16 DESC;
