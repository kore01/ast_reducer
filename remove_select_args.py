import sqlglot
from sqlglot import parse_one

sql = """SELECT CASE WHEN subq1. c13> subq1. c13 THEN c13 END, subq1. c13, CAST( subq1. c13 AS TEXT), subq1. c13 
FROM( 
    SELECT FALSE c13 
    FROM( 
        SELECT c2 c9, t1. c5 c11, t1. c1 
        FROM t0 t1 
        WHERE 89> t1. c1 
        ORDER BY c9, c11 
        LIMIT 2316622805712276698
    ) true 
    ORDER BY c13 ASC
) as subq1 
WHERE subq1. c13= CASE subq1. c13 
    WHEN subq1. c13= subq1. c13 THEN subq1. c13 
    ELSE subq1. c13 
END 
OR subq1. c13= subq1. c13;
"""

# Parse once and store number of expressions
tree = parse_one(sql)
select_clause = tree.find(sqlglot.exp.Select)
original_count = len(select_clause.expressions)

# Loop through and remove each expression one at a time
for i in range(original_count):
    modified_tree = parse_one(sql)
    modified_select = modified_tree.find(sqlglot.exp.Select)
    if i < len(modified_select.expressions):
        del modified_select.expressions[i]
    print(f"\n--- SQL with SELECT expression {i+1} removed ---")
    print(modified_tree.sql())
