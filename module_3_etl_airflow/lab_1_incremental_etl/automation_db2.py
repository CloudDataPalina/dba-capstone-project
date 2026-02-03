import os
import ibm_db
import mysql.connector


def _env(name: str, default: str | None = None) -> str:
    """Read environment variable with optional default; raise if missing."""
    value = os.getenv(name, default)
    if value is None or value == "":
        raise RuntimeError(f"Missing required environment variable: {name}")
    return value


# --- MySQL (staging) ---
MYSQL_HOST = _env("MYSQL_HOST")
MYSQL_PORT = int(os.getenv("MYSQL_PORT", "3306"))
MYSQL_USER = _env("MYSQL_USER")
MYSQL_PASSWORD = _env("MYSQL_PASSWORD")
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "sales")

# --- IBM DB2 (production DWH) ---
# Option 1: pass full DSN string via env (recommended for this lab)
DB2_DSN = _env("DB2_DSN")


def get_last_rowid() -> int:
    conn = ibm_db.connect(DB2_DSN, "", "")
    try:
        sql = "SELECT COALESCE(MAX(rowid), 0) AS max_rowid FROM sales_data"
        stmt = ibm_db.exec_immediate(conn, sql)
        row = ibm_db.fetch_assoc(stmt)
        # DB2 returns column names in uppercase by default
        return int(row["MAX_ROWID"])
    finally:
        ibm_db.close(conn)


def get_latest_records(last_rowid: int):
    conn = mysql.connector.connect(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DATABASE,
    )
    try:
        cursor = conn.cursor()
        sql = """
            SELECT rowid, product_id, customer_id, quantity
            FROM sales_data
            WHERE rowid > %s
            ORDER BY rowid
        """
        cursor.execute(sql, (last_rowid,))
        return cursor.fetchall()
    finally:
        try:
            cursor.close()
        except Exception:
            pass
        conn.close()


def insert_records(records) -> int:
    if not records:
        return 0

    conn = ibm_db.connect(DB2_DSN, "", "")
    try:
        sql = """
            INSERT INTO sales_data (rowid, product_id, customer_id, quantity)
            VALUES (?, ?, ?, ?)
        """
        stmt = ibm_db.prepare(conn, sql)

        inserted = 0
        for record in records:
            ibm_db.execute(stmt, record)
            inserted += 1

        return inserted
    finally:
        ibm_db.close(conn)


if __name__ == "__main__":
    last_row_id = get_last_rowid()
    print("Last rowid on production datawarehouse =", last_row_id)

    records = get_latest_records(last_row_id)
    print("New rows on staging datawarehouse =", len(records))

    inserted = insert_records(records)
    print("New rows inserted into production datawarehouse =", inserted)
