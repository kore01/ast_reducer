import subprocess
import tempfile
from pathlib import Path

def run_sqlite(version: str, sql_content: str) -> str:
    # Create temporary SQL file
    with tempfile.NamedTemporaryFile('w+', suffix='.sql', delete=False, encoding='utf-8') as tmp_sql:
        tmp_sql.write(sql_content)
        tmp_sql_path = Path(tmp_sql.name)

    try:
        # Build and run the process
        process = subprocess.Popen(
            [f"sqlite3-{version}"],
            stdin=open(tmp_sql_path, 'r', encoding='utf-8'),
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True
        )

        output, _ = process.communicate()
        exit_code = process.returncode

    finally:
        # Always clean up the temporary file
        tmp_sql_path.unlink(missing_ok=True)

    # Debug logging
    print(f"[DEBUG] exit code: {exit_code}")
    print(f"[DEBUG] output:\n{output}")

    return f"[EXIT CODE:{exit_code}]\n{output}"