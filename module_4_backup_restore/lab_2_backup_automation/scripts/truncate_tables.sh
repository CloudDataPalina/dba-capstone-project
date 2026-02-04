#!/bin/bash

DB_NAME="sales"

# Disable foreign key checks
mysql -e "SET FOREIGN_KEY_CHECKS=0;"

# Truncate all tables
TABLES=$(mysql -N -e "SHOW TABLES FROM ${DB_NAME};")

for TABLE in $TABLES
do
  mysql -e "TRUNCATE TABLE ${DB_NAME}.${TABLE};"
done

# Enable foreign key checks
mysql -e "SET FOREIGN_KEY_CHECKS=1;"

echo "All tables in database ${DB_NAME} have been truncated."
