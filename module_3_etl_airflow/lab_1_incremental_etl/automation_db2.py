import ibm_db
import mysql.connector

# -----------------------------
# MySQL (staging database)
# -----------------------------
MYSQL_HOST = "YOUR_MYSQL_HOST"
MYSQL_PORT = 3306
MYSQL_USER = "YOUR_MYSQL_USER"
MYSQL_PASSWORD = "YOUR_MYSQL_PASSWORD"
MYSQL_DATABASE = "sales"

# -----------------------------
# IBM DB2 (production data warehouse)
# -----------------------------
DB2_DSN = (
    "DRIVER={IBM DB2 ODBC DRIVER};"
    "DATABASE=bludb;"
    "HOSTNAME=YOUR_DB2_HOST;"
    "PORT=32286;"
    "PROTOCOL=TCPIP;"
    "UID=YOUR_DB2_USER;"
    "PWD=YOUR_DB2_PASSWORD;"
    "SECURITY=SSL;"
)

def get_last_rowid():
    conn = ibm_db.connect(DB2_DSN, "", "")
    sql = "SELECT COALESCE(MAX(rowid), 0) AS max_rowid FROM sales_data"
    stmt = ibm_db.exec_immediate(conn, sql)
    row = ibm_db.fetch_assoc(stmt)
    ibm_db.close(conn)
    return int(row["MAX_ROWID"])


def get_latest_records(last_rowid):
    conn = mysql.connector.connect(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DATABASE,
    )
    cursor = conn.cursor()

    sql = """
        SELECT rowid, product_id, customer_id, quantity
        FROM sales_data
        WHERE rowid > %s
        ORDER BY rowid
    """
    cursor.execute(sql, (last_rowid,))
    records = cursor.fetchall()

    cursor.close()
    conn.close()
    return records


def insert_records(records):
    conn = ibm_db.connect(DB2_DSN, "", "")

    sql = """
        INSERT INTO sales_data (rowid, product_id, customer_id, quantity)
        VALUES (?, ?, ?, ?)
    """

    stmt = ibm_db.prepare(conn, sql)

    for record in records:
        ibm_db.execute(stmt, record)

    ibm_db.close(conn)


# -----------------------------
# ETL execution
# -----------------------------
last_row_id = get_last_rowid()
print("Last rowid on production datawarehouse =", last_row_id)

records = get_latest_records(last_row_id)
print("New rows on staging datawarehouse =", len(records))

insert_records(records)
print("New rows inserted into production datawarehouse =", len(records))

