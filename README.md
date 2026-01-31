# DBA Capstone Project – End-to-End Relational Data Platform

![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?logo=postgresql&logoColor=white)
![Apache Airflow](https://img.shields.io/badge/Apache-Airflow-blue?logo=apacheairflow&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Shell_Scripts-121011?logo=gnu-bash&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## ✅ Project Status
Completed as part of the IBM Relational Database Administrator Professional Certificate.  
Demonstrates end-to-end relational database administration in an enterprise e-commerce scenario.

## 📌 Project Overview
This project is a **capstone project** completed as part of the **IBM Relational Database Administrator Professional Certificate**.

The goal of the project is to design, implement, and administer a **complete data platform** for a growing **e-commerce company**, covering the full lifecycle of relational data management — from OLTP systems to data warehousing, ETL pipelines, security, and optimization.

The project simulates a real-world enterprise environment and demonstrates practical **Database Administrator (DBA)** and **Data Engineering** skills.

---

## 🏗️ Business Scenario
You are a **Database Administrator** at an e-commerce company responsible for building a reliable, scalable, and secure data platform.

Your responsibilities include:
- Designing OLTP databases for transactional workloads
- Building a data warehouse for analytical queries
- Developing and automating ETL pipelines
- Implementing backup and recovery strategies
- Managing database security and access control
- Optimizing query performance and memory usage

---

## 🧠 Project Architecture
The platform follows a **hybrid data architecture**:

- **OLTP Database:** MySQL  
- **Staging & Data Warehouse:** PostgreSQL  
- **ETL & Orchestration:** Apache Airflow  
- **Automation & Scripting:** Bash, Python  

Transactional data is stored in MySQL and periodically extracted, transformed, and loaded into a PostgreSQL-based data warehouse using automated Airflow DAGs.

---

## 📁 Repository Structure
```text
dba-capstone-project/
│
├── README.md
├── module_1_oltp/
├── module_2_data_warehouse/
├── module_3_etl_airflow/
├── module_4_backup_restore/
├── module_5_security_optimization/
│
└── docs/
    └── architecture.md

```
---

## 🛠 Technologies Used
- **MySQL** – OLTP database design and administration  
- **PostgreSQL** – Data warehouse implementation  
- **Apache Airflow** – ETL pipeline orchestration  
- **Python** – DAG and workflow definitions  
- **Bash** – Automation scripts (backup, export)  
- **phpMyAdmin / pgAdmin** – Database administration  
- **Cloud IDE** – Development and testing environment  

---

## 📦 Project Modules

### Module 1 – OLTP Database & Platform Architecture
- Designed and implemented an OLTP database using MySQL
- Created and populated transactional tables
- Verified data integrity using SQL queries
- Created indexes for performance optimization
- Automated data export using Bash scripts

📁 `module_1_oltp/`

---

### Module 2 – Data Warehouse Design
- Designed and implemented a relational data warehouse
- Created multiple tables and defined schema relationships
- Executed analytical queries across individual and joined tables

📁 `module_2_data_warehouse/`

---

### Module 3 – ETL Pipelines with Apache Airflow
- Built ETL pipelines for data extraction, transformation, and loading
- Automated workflows using Apache Airflow DAGs
- Ensured reliable and repeatable data integration processes

📁 `module_3_etl_airflow/`

---

### Module 4 – Backup, Restore & Automation
- Implemented database backup and restore strategies
- Simulated data loss scenarios
- Automated backup and recovery operations using scripts

📁 `module_4_backup_restore/`

---

### Module 5 – Database Optimization & Security
- Optimized SQL queries for performance
- Managed user roles and access permissions
- Implemented data security and encryption techniques
- Improved memory usage and execution efficiency

📁 `module_5_security_optimization/`

---

## 🎯 Key Skills Demonstrated
- Relational database design (OLTP & DWH)
- SQL querying and optimization
- Database administration and automation
- ETL pipeline development
- Workflow orchestration with Apache Airflow
- Backup, recovery, and security best practices

---

## 📜 Certificate Program
This project was completed as part of the:

**IBM Relational Database Administrator Professional Certificate**

## 👩‍💻 Author

**Palina Krasiuk**  
Aspiring Cloud Data Engineer | ex-Senior Accountant  
[LinkedIn](https://www.linkedin.com/in/palina-krasiuk-954404372/) • [GitHub Portfolio](https://github.com/CloudDataPalina)
