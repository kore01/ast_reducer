import sqlglot
from sqlglot import parse_one, exp

def remove_where_args(sql: str, index: int) -> str:
    """
    Remove the `index`-th subcondition from the top-level WHERE clause (if it's a binary expression).
    
    Args:
        sql (str): The input SQL query.
        index (int): Zero-based index of the subcondition to remove.

    Returns:
        str: Modified SQL query with the selected subcondition removed.
    """
    def flatten_conditions(expr, expr_type):
        if isinstance(expr, expr_type):
            return flatten_conditions(expr.args['this'], expr_type) + flatten_conditions(expr.args['expression'], expr_type)
        else:
            return [expr]


    
    try:
        tree = parse_one(sql)
    except Exception as e:
        return ""
    
    where_clause = tree.find(exp.Where)
    select_node = tree.find(exp.Select)

    if where_clause and select_node and index == -1:
        select_node.set("where", None)
        return tree.sql(pretty=False, dialect='sqlite').replace("SELECT *", "SELECT*")
    if not where_clause:
        return ""
        raise ValueError("No WHERE clause found.")

    condition = where_clause.this
    expr_type = type(condition)

    if expr_type not in (exp.And, exp.Or):
        return ""
        raise ValueError("WHERE clause is not a compound AND/OR condition.")

    subconds = flatten_conditions(condition, expr_type)

    if index < 0 or index >= len(subconds):
        return ""
        raise IndexError("Condition index out of range.")

    # Remove the selected subcondition
    kept_conditions = [sc for j, sc in enumerate(subconds) if j != index]

    if kept_conditions:
        new_cond = kept_conditions[0]
        for sc in kept_conditions[1:]:
            new_cond = expr_type(this=new_cond, expression=sc)
        where_clause.set("this", new_cond)
    else:
        tree.set("where", None)

    return tree.sql(pretty=False, dialect='sqlite').replace("SELECT *", "SELECT*")


print(remove_where_args("INSERT INTO F SELECT * FROM (VALUES ((NOT false), false), (NULL, (NOT (NOT true)))) AS L WHERE (((+(+(-((+110) / (+((-(-150)) * ((247 * (91 * (-47))) + (-86)))))))) = ((((+(+(24 / (+((+89) * (+58)))))) * (-(-((193 + 223) / (-(222 / 219)))))) * (34 * 70)) * (+(+((((+(+(-202))) / (+52)) - (-(228 + (-104)))) * (-24)))))) = (false <> (66 <> 8)));", -1))
