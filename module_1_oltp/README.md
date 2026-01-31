# Module 1 – OLTP Database & Platform Architecture

## 📌 Module Overview
In this module, an **OLTP database** was designed and implemented for an e-commerce platform using **MySQL**.  
This database stores transactional sales data and serves as the primary data source for downstream ETL pipelines and the data warehouse.

The module establishes the foundation of the data platform by validating data ingestion, ensuring data integrity, and automating basic administrative tasks.

---

## 🎯 Objectives
- Design and implement an OLTP database schema
- Load transactional data into MySQL
- Validate data integrity using SQL queries
- Perform basic administrative tasks
- Automate data export using a Bash script

---
## 📁 Structure module_1_oltp
```
module_1_oltp/
├── README.md                     ← Module documentation
├── schema.sql                    ← OLTP table definition
├── verification_queries.sql      ← Data validation queries
├── indexing.sql                  ← Index creation and verification
├── datadump.sh                   ← Bash script for data export
├── oltpdata.csv                  ← Source transactional data for OLTP import
└── screenshots/                  ← Execution evidence
    ├── createtable.png           ← Table creation
    ├── importdata.png            ← CSV data import
    ├── listtables.png            ← SHOW TABLES
    ├── salesrows.png             ← Row count validation
    ├── listindexes.png           ← Index verification
    └── exportdata.png            ← mysqldump execution
```

## 🛠 Tools & Technologies
- MySQL
- phpMyAdmin
- Bash

---

## 🧱 Database Design

### Table: `sales_data`
The `sales_data` table stores transactional sales information, including product identifiers, customer identifiers, pricing, quantity, and timestamps.

Database schema is defined in:
[`schema.sql`](schema.sql)

---

## 📥 Data Ingestion
Transactional data was imported from a CSV file into the `sales_data` table using **phpMyAdmin**.

Data integrity was validated by:
- Listing tables in the database
- Counting total rows after import

Source data file:
[`oltpdata.csv`](oltpdata.csv)

Validation queries are stored in:
[`verification_queries.sql`](verification_queries.sql)

---

## ⚙️ Administrative Tasks

### Index Management
Indexes were created and verified to support efficient query execution on timestamp-based operations and future analytical workloads.

Index-related queries are stored in:
[`indexing.sql`](indexing.sql)

---

### Data Export Automation
A Bash script was implemented to automate data export from MySQL using `mysqldump`.

Export script:
[`datadump.sh`](datadump.sh)

The script exports all records from the `sales_data` table into a SQL dump file.

---

## 📸 Screenshots
This module includes screenshots demonstrating:
- Table creation
- Data import status
- Data validation queries
- Index listing
- Successful data export

Screenshots are available in:
[`screenshots/`](screenshots/)

---

## ✅ Module Outcome
- OLTP database successfully created
- Transactional data loaded and validated
- Indexes verified
- Data export automated using Bash

This module demonstrates core **Database Administration (DBA)** skills required for managing transactional databases in a production environment.

