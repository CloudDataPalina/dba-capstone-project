import psycopg2
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
# PostgreSQL (production data warehouse)
# -----------------------------
PG_HOST = "YOUR_PG_HOST"
PG_PORT = 5432
PG_DATABASE = "postgres"
PG_USER = "YOUR_PG_USER"
PG_PASSWORD = "YOUR_PG_PASSWORD"


def get_last_rowid():
    conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        database=PG_DATABASE,
        user=PG_USER,
        password=PG_PASSWORD
    )
    cur = conn.cursor()
    cur.execute("SELECT COALESCE(MAX(rowid), 0) FROM sales_data;")
    last_rowid = cur.fetchone()[0]
    cur.close()
    conn.close()
    return last_rowid


def get_latest_records(last_rowid):
    conn = mysql.connector.connect(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DATABASE
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
    # Connect to PostgreSQL (production DWH)
    conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        database=PG_DATABASE,
        user=PG_USER,
        password=PG_PASSWORD
    )
    cur = conn.cursor()

    sql = """
        INSERT INTO sales_data (rowid, product_id, customer_id, quantity)
        VALUES (%s, %s, %s, %s);
    """

    for record in records:
        cur.execute(sql, record)

    conn.commit()
    cur.close()
    conn.close()


# -----------------------------
# ETL execution
# -----------------------------
last_row_id = get_last_rowid()
print("Last row id on production datawarehouse = ", last_row_id)

new_records = get_latest_records(last_row_id)
print("New rows on staging datawarehouse = ", len(new_records))

insert_records(new_records)
print("New rows inserted into production datawarehouse = ", len(new_records))
