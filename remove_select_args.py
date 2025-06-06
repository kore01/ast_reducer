import sqlglot
from sqlglot import parse_one, exp

def remove_select_args(sql: str, index: int) -> str:
    """
    Remove the `index`-th element from the top-level SELECT clause.

    Args:
        sql (str): The input SQL query.
        index (int): Zero-based index of the SELECT element to remove.

    Returns:
        str: Modified SQL query with the selected SELECT element removed.
    """
    try:
        tree = parse_one(sql)
    except Exception as e:
        print("Failed to parse SQL:", e)
        return ""

    select = tree.find(exp.Select)
    if not select:
        print("No SELECT clause found.")
        return ""

    expressions = select.expressions
    if index < 0 or index >= len(expressions):
        print(index)
        print("Index out of range for SELECT expressions.")
        return ""

    # Remove the selected expression
    new_expressions = [expr for i, expr in enumerate(expressions) if i != index]

    if new_expressions:
        select.set("expressions", new_expressions)
    else:
        # If no select expressions left, remove them all (empty SELECT)
        select.set("expressions", [])

    return tree.sql()
