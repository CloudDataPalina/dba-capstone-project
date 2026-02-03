# Module 3 – ETL Pipelines & Workflow Orchestration

## 📌 Module Overview
This module focuses on ***ETL processes and data pipeline orchestration***.
It demonstrates how transactional data is incrementally synchronized between databases and how automated workflows are scheduled and monitored using ***Apache Airflow***.

The module consists of ***two practical labs***:
1. Incremental ETL pipeline between databases
2. Workflow orchestration with Apache Airflow DAGs

---

## 🎯 Learning Objectives
- Implement incremental ETL pipelines using Python
- Synchronize staging and production data warehouses
- Work with multiple database technologies (MySQL, IBM DB2, PostgreSQL)
- Build and schedule workflows using Apache Airflow
- Monitor and validate pipeline execution

---

## 📁 Module Structure
```
module_3_etl_airflow/
├── README.md                         ← Module documentation and explanation
│
├── lab_1_incremental_etl/            ← Incremental ETL: MySQL → Production DWH
│   ├── automation_db2.py             ← Incremental ETL script (MySQL → IBM DB2)
│   ├── automation_postgres.py        ← Incremental ETL script (MySQL → PostgreSQL)
│   │
│   ├── connectors/                   ← Database connection examples
│   │   ├── mysqlconnect.py           ← Python connector for MySQL (staging DB)
│   │   ├── db2connect.py             ← Python connector for IBM DB2
│   │   └── postgresqlconnect.py      ← Python connector for PostgreSQL
│   │
│   ├── data/                         ← Source data and database setup files
│   │   ├── sales.sql                 ← SQL script to create and populate sales tables
│   │   └── sales.csv                 ← Source CSV data for data loading
│   │
│   └── screenshots/                  ← Execution evidence and validation
│       ├── get_last_rowid_db2.png    ← DB2: last loaded row identification
│       ├── get_last_rowid_pg.png     ← PostgreSQL: last loaded row identification
│       ├── get_latest_records.png    ← MySQL: incremental data extraction
│       ├── insert_records_db2.png    ← DB2: incremental data insertion
│       ├── insert_records_pg.png     ← PostgreSQL: incremental data insertion
│       ├── synchronization_db2.png   ← DB2: successful ETL synchronization output
│       └── synchronization_pg.png    ← PostgreSQL: successful ETL synchronization output
│
└── lab_2_airflow_dag/                 ← Workflow orchestration with Apache Airflow
    ├── process_web_log.py             ← Airflow DAG definition
    │
    ├── data/                          ← Input data for DAG execution
    │   └── accesslog.txt              ← Web server log file (ETL input)
    │
    └── screenshots/                   ← Airflow execution and monitoring evidence
        ├── dag_args.png               ← DAG default arguments definition
        ├── dag_definition.png         ← DAG configuration and schedule
        ├── extract_data.png           ← extract_data task implementation
        ├── transform_data.png         ← transform_data task implementation
        ├── load_data.png              ← load_data task implementation
        ├── pipeline.png               ← Task dependency pipeline (ETL flow)
        ├── submit_dag.png             ← DAG submission via Airflow CLI
        ├── unpause_dag.png            ← DAG unpause confirmation
        └── dag_runs.png               ← DAG runs monitored in Airflow UI

```
---

## 🛠 Tools & Technologies
- Python – ETL logic and automation
- MySQL – Staging database
- IBM DB2 – Production data warehouse (Option A)
- PostgreSQL – Production data warehouse (Option B)
- Apache Airflow – Workflow orchestration
- Bash – Data extraction, transformation, and loading
- Docker / Cloud IDE (SN Labs) – Execution environment

---

## Lab 1 – Incremental ETL Pipeline (MySQL → Production DWH)
### Description
This lab **implements an incremental ETL pipeline** that synchronizes data from a **staging database (MySQL)** into a production data warehouse.
The same ETL pattern is implemented and validated against ***two different production targets***:
***Option A***: IBM DB2
***Option B***: PostgreSQL
This demonstrates portability of ETL logic across different database technologies.

### 🏗 Architecture
- ***Staging Database***: MySQL (`sales.sales_data`)
- ***Production Data Warehouse***: IBM DB2 or PostgreSQL
- ***Incremental Key***: `rowid`

### ⚙️ ETL Logic
1. Identify the last loaded record in the production data warehouse
(`SELECT COALESCE(MAX(rowid), 0)`)
2. Extract new records from the MySQL staging database
(`WHERE rowid > last_rowid`)
3. Insert incremental records into the production data warehouse

### 🧩 Implemented Functions

-`get_last_rowid()`
Retrieves the maximum rowid from the production data warehouse.
- `get_latest_records(last_rowid)`
Extracts new records from the MySQL staging database.
- `insert_records(records)`
Loads the incremental records into the production data warehouse.

### 🧪 Validation & Evidence
Execution output confirms successful synchronization:
- Last row ID detected in production
- Number of new records extracted from staging
- Number of records successfully inserted into production
Screenshots in the `screenshots/` folder provide execution proof for:
- DB2-based ETL run
- PostgreSQL-based ETL run

---

## Lab 2 – Data Pipelines with Apache Airflow
### 📖 Description
This lab demonstrates workflow orchestration using **Apache Airflow** by building a DAG that processes web server log files.
The pipeline extracts data, applies transformations, and loads the processed output into an archive file. 
 
### 🧠 DAG Details
- ***DAG ID***: process_web_log
- ***Schedule***: Daily (@daily)
- ***Operator Type***: BashOperator
- ***Catchup***: Disabled

### 🔄 Pipeline Tasks
1. **extract_data**
Extracts IP addresses from the web server log file.
2. **transform_data**
Filters out specific IP addresses from the extracted data.
3. **load_data**
Archives the transformed data into a tar file.

### 🔗 Task Dependency
```
extract_data → transform_data → load_data
```
### 📦 Pipeline Artifacts
- `extracted_data.txt`
- `transformed_data.txt`
- `weblog.tar`

## 📊 Monitoring & Execution
- DAG submitted and triggered via Airflow CLI
- DAG unpaused and executed successfully
- Pipeline runs monitored using the Airflow Web UI
Execution screenshots are provided in the `screenshots/` directory.

---

## 🎯 Skills Demonstrated
- Incremental ETL design and implementation
- Multi-database data synchronization
- Python-based data automation
- Workflow orchestration with Apache Airflow
- Bash-based data processing
- Monitoring and validation of data pipelines


## 🔐 Security Note
All database credentials and sensitive connection details have been removed or masked for security reasons.
Environment variables are recommended for local execution.


## ✅ Module Outcome
- Incremental ETL pipelines successfully implemented and validated
- ETL logic tested on both IBM DB2 and PostgreSQL
- Automated workflows built and monitored using Apache Airflow
- Reliable and repeatable data integration achieved


