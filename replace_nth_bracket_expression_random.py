import re
import random

def replace_nth_bracket_expression_random(sql: str, index: int) -> str:
    """
    Replace the n-th bracketed expression in the SQL string with a random one of its inner values.

    Args:
        sql (str): The input SQL query.
        index (int): The index (0-based) of the bracketed expression to replace.

    Returns:
        str: Modified SQL query.
    """
    # Find all bracketed expressions using a stack-based parser
    positions = []
    stack = []

    for i, char in enumerate(sql):
        if char == '(':
            stack.append(i)
        elif char == ')':
            if stack:
                start = stack.pop()
                end = i + 1
                positions.append((start, end))

    if index < 0 or index >= len(positions):
        raise IndexError("Bracket expression index out of range")

    start, end = positions[index]
    original_expr = sql[start:end]

    # Strip outer parentheses and parse inner elements (rough parsing)
    inner = original_expr[1:-1].strip()

    # Split at commas that are not inside other parentheses
    inner_parts = [x.strip() for x in re.split(r',(?![^()]*\))', inner)]

    if not inner_parts:
        return sql  # No change

    # Choose one value at random
    chosen = random.choice(inner_parts)
    new_expr = f"({chosen})"

    return sql[:start] + new_expr + sql[end:]


sql = "INSERT INTO V SELECT* FROM( VALUES(( NULL), false),( NULL, NULL)) WHERE(( false< true)>( NOT true));"
print(replace_nth_bracket_expression_random(sql, 6))  # Simplifies (( NULL), false)