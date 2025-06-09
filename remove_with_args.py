import os
import sys
import sqlglot
from sqlglot import parse_one, exp

def remove_with_args(sql: str, index: int) -> str:
    # Parse the SQL into an AST
    try: 
        expression = parse_one(sql, dialect = 'sqlite')
    except sqlglot.errors.ParseError:
            return ""

    index-=1

    if not isinstance(expression, exp.With):
        # Might be a With wrapped around a Select
        if isinstance(expression, exp.Select) and isinstance(expression.args.get("with"), exp.With):
            with_expr = expression.args["with"]
        elif isinstance(expression, exp.With):
            with_expr = expression
        else:
            return ""
    else:
        with_expr = expression

    def is_valid_sql(sql: str) -> bool:
        try:
            parse_one(sql)
            return True
        except sqlglot.errors.ParseError:
            return False

    # Get the list of CTEs
    ctes = with_expr.expressions
    #print(ctes)
    #print(len(ctes))

    if index < 0 or index >= len(ctes):
        return ""
        raise IndexError(f"CTE index {index} out of range (found {len(ctes)} CTEs)")

    # Remove the CTE
    del ctes[index]
    #print(ctes)
    # If no CTEs remain, remove the WITH clause entirely
    if not ctes:
        if isinstance(expression, exp.With):
            return expression.this.sql()
        elif isinstance(expression, exp.Select):
            expression.set("with", None)
    else:
        # Reassign updated CTEs
        with_expr.set("expressions", ctes)

    output = expression.sql(pretty=False, dialect='sqlite').replace("SELECT *", "SELECT*")
    
    #print(expression.sql(pretty=True, dialect='sqlite').replace("SELECT *", "SELECT*"))
    return output

#sql = 'WITH temp AS (SELECT a, b, c FROM t) SELECT x, y, z FROM main;'
#print(remove_with_args(sql, 1))

