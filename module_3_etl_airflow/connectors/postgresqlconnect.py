import psycopg2

# ----------------------------------
# PostgreSQL connection details
# (masked for GitHub portfolio)
# ----------------------------------
dsn_hostname = "YOUR_PG_HOST"
dsn_user = "YOUR_PG_USER"
dsn_pwd = "YOUR_PG_PASSWORD"
dsn_port = "5432"
dsn_database = "postgres"

# Create connection
conn = psycopg2.connect(
    database=dsn_database,
    user=dsn_user,
    password=dsn_pwd,
    host=dsn_hostname,
    port=dsn_port
)

cursor = conn.cursor()

# Create table
SQL = """
CREATE TABLE IF NOT EXISTS products(
    rowid INTEGER PRIMARY KEY NOT NULL,
    product VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL
)
"""
cursor.execute(SQL)
conn.commit()
print("Table created")

# Insert data
cursor.execute(
    "INSERT INTO products(rowid, product, category) VALUES (1, 'Television', 'Electronics')"
)
cursor.execute(
    "INSERT INTO products(rowid, product, category) VALUES (2, 'Laptop', 'Electronics')"
)
cursor.execute(
    "INSERT INTO products(rowid, product, category) VALUES (3, 'Mobile', 'Electronics')"
)
conn.commit()

# Insert list of records
list_ofrecords = [
    (5, "Mobile", "Electronics"),
    (6, "Mobile", "Electronics")
]

for row in list_ofrecords:
    SQL = "INSERT INTO products(rowid, product, category) VALUES (%s, %s, %s)"
    cursor.execute(SQL, row)
    conn.commit()

# Query data
cursor.execute("SELECT * FROM products;")
rows = cursor.fetchall()

# Close connection
conn.close()

for row in rows:
    print(row)
