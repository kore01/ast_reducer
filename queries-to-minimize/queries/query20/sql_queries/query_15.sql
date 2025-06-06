SELECT subq0.c9 AS c13, subq0.c7 AS c14, 14 AS c15
FROM (SELECT t1.c3 AS c5, 
    CASE t1.c4 WHEN t1.c0 <> t1.c0 THEN t1.c4
         WHEN false OR t1.c4 <> t1.c4 AND t1.c2 >= t1.c2 THEN 
     CASE t1.c4 WHEN t1.c2 <= t1.c2 THEN trim( NULL)
          WHEN t1.c4 <> t1.c4 THEN t1.c4
          WHEN t1.c2 IS NULL THEN t1.c4
          WHEN t1.c1 <> t1.c1 THEN t1.c4
          WHEN t1.c3 = t1.c3 THEN t1.c4
          WHEN t1.c1 IS NULL THEN t1.c4
          WHEN t1.c4 IS NOT NULL THEN t1.c4
          WHEN 'text17' >= 'text32' OR t1.c4 IS NOT NULL THEN t1.c4
          WHEN true THEN t1.c4
          WHEN t1.c4 >= t1.c4 THEN t1.c4
          WHEN t1.c2 > t1.c2 THEN t1.c4
          WHEN t1.c1 <> t1.c0 THEN t1.c4
          ELSE t1.c4
     END
         ELSE t1.c4
    END AS c6, t1.c2 AS c7, t1.c1 AS c8, t1.c1 AS c9, t1.c2 AS c10, 
    CASE WHEN t1.c0 = t1.c0 AND t1.c3 IS NOT NULL AND t1.c1 = 
     CASE WHEN t1.c2 <> t1.c2 THEN t1.c0
          ELSE t1.c0
     END AND t1.c1 <> t1.c1 OR t1.c2 = t1.c2 THEN 96
         ELSE t1.c2
    END AS c11, t1.c3 AS c12
   FROM t0 AS t1
   WHERE t1.c0 <> TRUE AND t1.c1 <> t1.c0
   ORDER BY c7 ASC, c11
   LIMIT 4224862539711498118 OFFSET 706990438318866717) as subq0
WHERE subq0.c7 <= subq0.c10
ORDER BY c14 COLLATE NOCASE;
