SELECT subq1.c22 AS c25, subq1.c24 AS c26, subq1.c22 AS c27, subq1.c18 AS c28, NULL AS c29
FROM (SELECT subq0.c8 AS c9, subq0.c8 AS c10, subq0.c7 AS c11, subq0.c8 AS c12, subq0.c7 AS c13, subq0.c7 AS c14, subq0.c7 AS c15, subq0.c7 AS c16, COALESCE(subq0.c8, subq0.c8, subq0.c7, subq0.c8) AS c17, subq0.c8 AS c18, subq0.c8 AS c19, subq0.c7 AS c20, subq0.c8 AS c21, subq0.c7 AS c22, subq0.c8 AS c23, subq0.c7 AS c24
   FROM (SELECT t1.c4 AS c7, t1.c0 AS c8
      FROM t0 AS t1
      WHERE false
      ORDER BY c7 DESC
      LIMIT 8847097998777524965 ) as subq0
   WHERE true
   ORDER BY c12, c23 ASC, c23 ASC
   LIMIT 7993381303698447318 OFFSET 3819776743753519267) as subq1
WHERE subq1.c9 <> subq1.c21
ORDER BY c28 COLLATE BINARY, c26 COLLATE NOCASE
LIMIT 751185305895327053 OFFSET 9030370310033329133;
