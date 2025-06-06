import os
import sys
import re


from pathlib import Path

def get_sql_statements(input_path):
    input_path = Path(input_path)
    
    # Read the file content
    with input_path.open("r", encoding="utf-8") as f:
        content = f.read()

    # Split on ";" followed by space or newline:
    queries = [q.strip() for q in re.split(r';(?=\s|\n)', content) if q.strip()]


    # Create output directory under the parent of the input file
    output_dir = input_path.parent / "sql_queries"
    output_dir.mkdir(exist_ok=True)

    # Write each query to its own file
    for i, query in enumerate(queries, 1):
        output_file = output_dir / f"query_{i}.sql"
        with output_file.open("w", encoding="utf-8") as f:
            f.write(query + ";\n")

    print(f"Done! Queries written to '{output_dir}'.")


if __name__ == "__main__":
    get_sql_statements(sys.argv[1])
