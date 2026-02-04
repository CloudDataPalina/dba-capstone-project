# Database Architecture Overview

This document describes the overall architecture of the **DBA Capstone Project**,
including database layers, data flow, security controls, and maintenance processes.

## High-Level Data Architecture
```
OLTP (MySQL)
   |
   |  ETL (Airflow DAGs)
   v
Data Warehouse (MySQL/PostgreSQL)
```
---

## 1. System Overview

The project simulates a real-world data platform consisting of:

- OLTP database for transactional data
- Data Warehouse for analytics
- ETL pipelines for data movement
- Backup and recovery mechanisms
- Security and access control policies

All components are implemented using **MySQL** and supporting tools.

---

## 2. Database Layers

### 2.1 OLTP Layer
- Purpose: Store transactional sales data
- Database: `sales`
- Tables:
  - `FactSales`
  - `DimDate`
  - `DimCountry`
  - `DimCategory`
- Characteristics:
  - Normalized schema
  - High write frequency
  - Primary keys and indexes

---

### 2.2 Data Warehouse Layer
- Purpose: Analytical reporting and aggregation
- Schema type: Star schema
- Fact table:
  - `FactSales`
- Dimension tables:
  - `DimDate`
  - `DimCountry`
  - `DimCategory`
- Used for analytical queries and reporting

---

## 3. Data Integration (ETL)

- Source: OLTP database
- Target: Data Warehouse
- Tool: Apache Airflow
- ETL process:
  1. Extract data from OLTP tables
  2. Transform data (cleansing and formatting)
  3. Load data into warehouse tables
- Scheduling:
  - DAG-based orchestration
  - Automated execution

This approach ensures repeatable, reliable, and automated data movement between systems.

---

## 4. Backup and Recovery

- Backup strategy:
  - Manual backups using `mysqldump`
  - Automated backups using Bash scripts
- Automation:
  - CRON-based scheduling
  - Timestamped and compressed backups
- Recovery:
  - Restore tables and databases from backups
  - Data loss simulation and recovery validation

---

## 5. Security and Access Control

### 5.1 User Roles
- `db_admin`: Full administrative privileges
- `db_analyst`: Read access with analytical capabilities
- `db_reporter`: Read-only access
- `db_external`: Restricted column-level access

### 5.2 Data Protection
- Sensitive column (`amount`) encrypted using AES encryption
- Encrypted data stored as binary values
- Decryption performed only with valid encryption keys

---

## 6. Performance Optimization

- Indexes created to improve query performance
- Query execution analyzed using `EXPLAIN`
- Column data types optimized to reduce memory usage
- Table optimization executed using `OPTIMIZE TABLE`

---

## 7. Summary

This architecture demonstrates a complete database lifecycle:
- Transaction processing
- Analytical data modeling
- Automated ETL pipelines
- Backup and disaster recovery
- Security and performance optimization

The project reflects practical Database Administration and Data Engineering concepts.
