import sqlglot
from sqlglot import parse_one, exp

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

# Parse the SQL
tree = parse_one(sql)

# Find the WHERE clause expression
where_clause = tree.find(exp.Where)
if where_clause:
    condition = where_clause.this

    # Flatten binary expressions (AND/OR chain)
    if isinstance(condition, (exp.And, exp.Or)):
        # Extract all subconditions
        def flatten_conditions(expr):
            if isinstance(expr, type(condition)):
                return flatten_conditions(expr.args['this']) + flatten_conditions(expr.args['expression'])
            else:
                return [expr]

        subconds = flatten_conditions(condition)
        print(f"Found {len(subconds)} sub-conditions in WHERE clause.")

        # Iteratively remove each subcondition
        for i in range(len(subconds)):
            # Re-parse the SQL fresh each time
            modified_tree = parse_one(sql)
            mod_where = modified_tree.find(exp.Where)
            mod_condition = mod_where.this

            # Rebuild condition skipping the i-th subcondition
            kept_conditions = [sc for j, sc in enumerate(flatten_conditions(mod_condition)) if j != i]

            # Reconstruct binary chain (left-associative)
            if kept_conditions:
                new_cond = kept_conditions[0]
                for sc in kept_conditions[1:]:
                    new_cond = type(mod_condition)(this=new_cond, expression=sc)
                mod_where.set("this", new_cond)
            else:
                # No conditions left: remove WHERE clause entirely
                modified_tree.set("where", None)

            print(f"\n--- SQL with WHERE condition {i+1} removed ---")
            print(modified_tree.sql())
    else:
        print("WHERE clause is not a compound condition (no AND/OR). Nothing to remove.")
else:
    print("No WHERE clause found.")
