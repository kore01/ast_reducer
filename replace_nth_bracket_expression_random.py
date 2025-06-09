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
    allowed_globals = {"__builtins__": None}
    try:
        return eval(expr, allowed_globals, {})
    except Exception:
        return None

def replace_nth_bracket_expression_random(sql: str, index: int) -> str:
    #print(sql)
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
    
    #print(original_expr)

    inner = original_expr[1:-1].strip()

    python_expr = sql_to_python_expr(inner)
    result = safe_eval(python_expr)

    if result is not None:
        if result is True:
            new_expr = 'TRUE'
        elif result is False:
            new_expr = 'FALSE'
        elif result is None:
            new_expr = 'NULL'
        else:
            new_expr = str(result)
    else:
        inner_parts = [x.strip() for x in re.split(r',(?![^()]*\))', inner)]
        if not inner_parts:
            return sql
        new_expr = random.choice(inner_parts)

    return sql[:start] + new_expr + sql[end:], sql[:start] + ' TRUE ' + sql[end:], sql[:start] + ' FALSE ' + sql[end:]

# Test
#sql = "INSERT INTO F SELECT* FROM( VALUES( True, False),( NULL, TRUE)) WHERE((( 110/( 150))=- 0)=( false<>( 66<> 8)));"
#print(replace_nth_bracket_expression_random(sql, 5))
