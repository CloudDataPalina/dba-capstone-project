#!/bin/bash

DB_NAME="sales"
BACKUP_DIR="/home/theia/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_sales_${TIMESTAMP}.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Check if database exists
if ! mysql -e "USE ${DB_NAME};" 2>/dev/null; then
  echo "Database ${DB_NAME} does not exist."
  exit 1
fi

# Backup database and compress
mysqldump "${DB_NAME}" | gzip > "${BACKUP_DIR}/${BACKUP_FILE}"

echo "Backup created: ${BACKUP_DIR}/${BACKUP_FILE}"

# Delete backups older than 10 days
find "${BACKUP_DIR}" -type f -name "backup_sales_*.gz" -mtime +10 -exec rm -f {} \;

echo "Old backups older than 10 days removed."
