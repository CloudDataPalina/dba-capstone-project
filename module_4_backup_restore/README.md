# Module 4 – Database Backup, Restore & Automation

## 📌 Module Overview
This module focuses on **database backup, restore, and automation techniques**.
It demonstrates how to protect data from unexpected loss by creating reliable backups, restoring databases after failures, and automating backup processes to improve operational efficiency.

The module consists of **two practical labs**:
1. Manual database backup and restore
2. Automated backup, retention, and recovery using Bash and CRON

---

## 🎯 Learning Objectives
- Perform database backup and restore operations
- Apply best practices for data protection and recovery
- Automate database maintenance tasks
- Schedule recurring backup jobs
- Simulate data loss and recover databases from backups

---

## 📁 Module Structure
```
module_4_backup_restore/
├── README.md                        ← Module documentation and explanation
│
├── lab_1_backup_restore/            ← Manual backup and restore (MySQL CLI)
│ ├── commands/                      ← Commands used in the lab
│ │ ├── backup_command.txt           ← mysqldump command
│ │ ├── drop_table_command.txt       ← DROP TABLE command
│ │ └── restore_command.txt          ← Restore command via CLI
│ │
│ ├── backups/                       ← Manual backup files
│ │ └── sales_backup.sql             ← Backup of FactSales table
│ │
│ └── screenshots/                   ← Execution evidence
│ ├── FactSales_backup.png           ← Backup creation output
│ ├── FactSales_dropped.png          ← Table deletion confirmation
│ └── FactSales_restored.png         ← Successful table restore
│
└── lab_2_backup_automation/         ← Automated backup and recovery
├── scripts/                         ← Automation scripts
│ ├── backup_automation.sh           ← Automated backup script
│ └── truncate_tables.sh             ← Data loss simulation script
│
├── cron/                            ← Scheduling configuration
│ └── cron_job.txt                   ← CRON job definition
│
├── backups/                         ← Automated backup files (.gz)
│ └── backup_sales_<timestamp>.gz
│
└── screenshots/                     ← Automation and recovery evidence
├── backup_automation.png            ← Backup script content
├── cron_job_output.png              ← Scheduled backup execution
├── data_truncate_code.png           ← Truncated tables confirmation
└── restored_data_automation.png     ← Database restored from backup
```

---

## 🛠 Tools & Technologies
- MySQL – Relational database management system
- MySQL CLI – Manual backup and restore
- Bash – Automation scripting
- CRON – Job scheduling
- gzip – Backup compression
- Docker / Cloud IDE (IBM Skills Network Labs) – Execution environment

---

## Lab 1 – Manual Database Backup & Restore
### Description
This lab demonstrates how to **manually protect and recover database data** using MySQL command-line tools.
A backup of the `FactSales` table is created, data loss is simulated by dropping the table, and the table is fully restored from the backup file.

### Key Activities
- Create a backup of a MySQL table using `mysqldump`
- Simulate data loss by dropping the table
- Restore the table from a backup file
- Validate data integrity after recovery

### 📄 Commands Used
 - Command list:
  - [`backup_command.txt`](lab_1_backup_restore/commands/backup_command.txt)
  - [`drop_table_command.txt`](lab_1_backup_restore/commands/drop_table_command.txt)
  - [`restore_command.txt`](lab_1_backup_restore/commands/restore_command.txt)


### 🧪 Validation & Evidence
- Backup creation, table drop, and restore proof:
  - [`screenshots/`](lab_1_backup_restore/screenshots/)
  
---

## Lab 2 – Automated Backup & Recovery
### Description
This lab focuses on **automating database backup and restore operations**.
A Bash script is created to generate compressed backups at regular intervals, enforce a retention policy, and restore the database after a simulated data loss.

### Key Activities
- Create an automated backup Bash script
- Compress backups and store them with timestamps
- Configure CRON to execute backups every 3 minutes
- Implement backup retention (10 days)
- Simulate data loss and restore the database from the latest backup

### 📄 Scripts & Commands
- Automated backup script:
  - [`backup_automation.sh`](lab_2_backup_automation/scripts/backup_automation.sh)
- Data loss simulation script:
  - [`truncate_tables.sh`](lab_2_backup_automation/scripts/truncate_tables.sh)
- Cron scheduling commands:
  - [`cron_job.txt`](lab_2_backup_automation/cron/cron_job.txt)


### 🧪 Validation & Evidence
- Automation execution, cron jobs, and data restoration proof:
  - [`screenshots/`](lab_2_backup_automation/screenshots/)

---

## 🎯 Skills Demonstrated
- Database backup and recovery strategies
- MySQL administration fundamentals
- Bash scripting for automation
- CRON job scheduling
- Backup retention management
- Disaster recovery simulation

---

## 🔐 Security Note
All database credentials and sensitive information have been removed or masked.
Environment variables or secure configuration files are recommended for real-world usage.

---

## ✅ Module Outcome
- Reliable backup and restore processes implemented
- Automated backup system configured and scheduled
- Data loss scenarios successfully simulated and recovered
- Improved database reliability and operational resilience
- End-to-end backup lifecycle implemented and validated

