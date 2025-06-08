def remove_redundant_parentheses(sql: str) -> str:
    def is_balanced(s: str) -> bool:
        depth = 0
        for c in s:
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
                if depth < 0:
                    return False
        return depth == 0

    def strip_nested_parentheses(expr: str) -> str:
        # Remove nested parentheses only if they fully enclose the expression
        while expr.startswith('(') and expr.endswith(')') and is_balanced(expr[1:-1]):
            inner = expr[1:-1].strip()
            # Only strip if inner also starts/ends with '(' to avoid removing the last pair
            if inner.startswith('(') and inner.endswith(')') and is_balanced(inner[1:-1]):
                expr = inner
            else:
                break
        return expr

    def process(sql: str) -> str:
        result = ''
        i = 0
        while i < len(sql):
            if sql[i] == '(':
                start = i
                depth = 1
                i += 1
                while i < len(sql) and depth > 0:
                    if sql[i] == '(':
                        depth += 1
                    elif sql[i] == ')':
                        depth -= 1
                    i += 1
                inner = sql[start+1:i-1]
                processed_inner = process(inner)
                stripped = strip_nested_parentheses(f'({processed_inner})')
                result += stripped
            else:
                result += sql[i]
                i += 1
        return result

    return process(sql)
