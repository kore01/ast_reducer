import re
import random

def sql_to_python_expr(expr: str) -> str:
    # Map SQL literals to Python literals
    expr = expr.upper()
    expr = expr.replace('TRUE', 'True')
    expr = expr.replace('NOT True', 'False')
    expr = expr.replace('FALSE', 'False')
    expr = expr.replace('NOT False', 'True')
    expr = expr.replace('NULL', 'None')

    # Replace SQL logical operators with Python ones
    expr = re.sub(r'\bNOT\b', 'not ', expr)
    expr = re.sub(r'\bAND\b', ' and ', expr)
    expr = re.sub(r'\bOR\b', ' or ', expr)

    # Replace equality and inequality operators
    expr = expr.replace('<>', '!=')

    # Handle double negatives: -(-150) -> --150 (which Python accepts)
    # No extra change needed here

    return expr

def safe_eval(expr: str):
    """
    Safely evaluate a Python expression converted from SQL.
    Only allows basic arithmetic and logical operations.
    """
    # Allowed builtins (empty)
    allowed_builtins = {}

    # Allowed globals - none
    allowed_globals = {"__builtins__": None}

    # Allowed locals - empty
    allowed_locals = {}

    try:
        return eval(expr, allowed_globals, allowed_locals)
    except Exception:
        return None

def replace_nth_bracket_expression_random(sql: str, index: int) -> str:
    """
    Replace the n-th bracketed expression in the SQL string with a simplified value:
    - If the expression inside the parentheses is arithmetic or logical, evaluate it.
    - Otherwise, randomly choose one of the comma-separated inner values.
    Remove the parentheses in either case.
    """
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

    inner = original_expr[1:-1].strip()
    
    # Try to evaluate the whole inner expression as arithmetic/logical
    python_expr = sql_to_python_expr(inner)
    result = safe_eval(python_expr)
    
    if result is not None:
        # Convert result back to SQL representation for booleans and None
        if result is True:
            new_expr = 'TRUE'
        elif result is False:
            new_expr = 'FALSE'
        elif result is None:
            new_expr = 'NULL'
        else:
            new_expr = str(result)
    else:
        # Fallback: split by commas (not inside nested parens)
        inner_parts = [x.strip() for x in re.split(r',(?![^()]*\))', inner)]
        if not inner_parts:
            return sql
        new_expr = random.choice(inner_parts)

    return sql[:start] + new_expr + sql[end:]

# Example test
sql = "INSERT INTO V SELECT* FROM( VALUES(( NULL), false),( NULL, NULL)) WHERE(( false< true)>( NOT true));"
print(replace_nth_bracket_expression_random(sql, 4))  # Should try to evaluate (( NULL), false) or pick random
