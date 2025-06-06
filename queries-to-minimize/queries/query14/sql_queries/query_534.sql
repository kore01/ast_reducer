WITH 
            t1_stats AS (
                SELECT c1, 
                    COUNT(*) as count,
                    AVG(c0) as avg_pk
                FROM t5
                GROUP BY c1
            ),
            t2_derived AS (
                SELECT c0, c3,
                    CASE 
                        WHEN c3 IS NULL THEN 'Unknown'
                        WHEN c3 < 50 THEN 'Low'
                        ELSE 'High'
                    END as category
                FROM t3
            )
            SELECT main.*, 
                (SELECT AVG(count) FROM t1_stats) as overall_avg,
                (
                    SELECT COUNT(*) FROM (
                        SELECT t3.c0, 
                                LAG(t3.c4) OVER(ORDER BY t3.c0) as prev_val,
                                LEAD(t3.c4) OVER(ORDER BY t3.c0) as next_val
                        FROM t0 t3
                        WHERE t3.c0 IN (
                            SELECT td.c0 FROM t2_derived td
                            WHERE td.category = main.category
                            UNION
                            SELECT ts.avg_pk FROM t1_stats ts
                            WHERE ts.c1 = main.c1
                        )
                    ) complex_window
                    WHERE complex_window.prev_val IS NOT NULL
                    OR complex_window.next_val IS NOT NULL
                ) as window_matches
            FROM (
                SELECT ts.c1, td.category,
                    ts.count, ts.avg_pk,
                    DENSE_RANK() OVER(PARTITION BY td.category ORDER BY ts.count DESC) as rank_in_category
                FROM t1_stats ts
                CROSS JOIN (
                    SELECT DISTINCT category FROM t2_derived
                ) td
            ) main
            WHERE main.rank_in_category <= 2
            ORDER BY main.category, main.rank_in_category;
