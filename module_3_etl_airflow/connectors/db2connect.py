# This program requires the python module ibm-db to be installed.
# Install it using the below command:
# python3.11 -m pip install --force-reinstall ibm_db==3.1.0 ibm_db_sa==0.3.3

import ibm_db

# -------------------------------------------------
# Connection details (masked for GitHub portfolio)
# -------------------------------------------------
dsn_hostname = "YOUR_DB2_HOSTNAME"
dsn_uid = "YOUR_DB2_USER"
dsn_pwd = "YOUR_DB2_PASSWORD"
dsn_port = "32286"
dsn_database = "bludb"
dsn_driver = "{IBM DB2 ODBC DRIVER}"
dsn_protocol = "TCPIP"
dsn_security = "SSL"

# Create the DSN connection string
dsn = (
    "DRIVER={0};"
    "DATABASE={1};"
    "HOSTNAME={2};"
    "PORT={3};"
    "PROTOCOL={4};"
    "UID={5};"
    "PWD={6};"
    "SECURITY={7};"
).format(
    dsn_driver, dsn_database, dsn_hostname, dsn_port, 
    dsn_protocol, dsn_uid, dsn_pwd, dsn_security
)

# create connection
conn = ibm_db.connect(dsn, "", "")
print("Connected to database:", dsn_database)

# create table
SQL = """CREATE TABLE IF NOT EXISTS products(
    rowid INTEGER PRIMARY KEY NOT NULL,
    product varchar(255) NOT NULL,
    category varchar(255) NOT NULL
)"""

ibm_db.exec_immediate(conn, SQL)
print("Table created")

# insert data
SQL = "INSERT INTO products(rowid, product, category) VALUES (?, ?, ?)"
stmt = ibm_db.prepare(conn, SQL)

rows = [
    (1, "Television", "Electronics"),
    (2, "Laptop", "Electronics"),
    (3, "Mobile", "Electronics")
]

for r in rows:
    ibm_db.execute(stmt, r)

# query data
SQL = "SELECT * FROM products"
stmt = ibm_db.exec_immediate(conn, SQL)

t = ibm_db.fetch_tuple(stmt)
while t:
    print(t)
    t = ibm_db.fetch_tuple(stmt)

# close connection
ibm_db.close(conn)
print("Connection closed")
