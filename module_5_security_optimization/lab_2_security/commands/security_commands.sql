-- ============================================
-- Lab 2: Access Control & Data Encryption
-- Module 5 – Database Optimization & Security
-- ============================================

-- Select database
USE sales;

-- ------------------------------------------------
-- Task 1: User access management (RBAC)
-- ------------------------------------------------

-- 1a) Admin user: full privileges on sales database
CREATE USER 'db_admin'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON sales.* TO 'db_admin'@'localhost';
FLUSH PRIVILEGES;

-- 1b) Analyst user: SELECT + structural privileges (no data modification)
CREATE USER 'db_analyst'@'localhost' IDENTIFIED BY '';
GRANT SELECT,
      CREATE VIEW, SHOW VIEW,
      CREATE ROUTINE,
      CREATE TEMPORARY TABLES
ON sales.* TO 'db_analyst'@'localhost';
FLUSH PRIVILEGES;

-- 1c) Reporter user: read-only access
CREATE USER 'db_reporter'@'localhost' IDENTIFIED BY '';
GRANT SELECT ON sales.* TO 'db_reporter'@'localhost';
FLUSH PRIVILEGES;

-- 1d) External user: limited access (no amount column)
CREATE USER 'db_external'@'localhost' IDENTIFIED BY '';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'db_external'@'localhost';

-- Database-level (minimal): allow reading the sales database
GRANT SELECT ON sales.* TO 'db_external'@'localhost';

-- Table + column-level: allow SELECT only on specific columns (no amount)
GRANT SELECT (orderid, dateid, countryid, categoryid)
ON sales.FactSales TO 'db_external'@'localhost';

FLUSH PRIVILEGES;

-- ------------------------------------------------
-- Task 2: Encrypt sensitive data (FactSales.amount)
-- ------------------------------------------------

-- 2.1) Create SHA-256 hash for the encryption passphrase
SELECT SHA2('sales info encryption', 256) AS passphrase_hash;

-- 2.2) Change amount data type to VARBINARY(255)
ALTER TABLE FactSales
MODIFY amount VARBINARY(255);

-- 2.3) Encrypt amount values using AES_ENCRYPT + UNHEX(hashed passphrase)
UPDATE FactSales
SET amount = AES_ENCRYPT(
    amount,
    UNHEX('e7826d5764b270b972617204cfe9331ab7d93968f16bb55bead11a3df3fb0128')
);

-- 2.4) Query encrypted data (without decryption key)
SELECT orderid, dateid, countryid, categoryid, amount
FROM FactSales
LIMIT 5;

-- 2.5) Query decrypted data (with decryption key)
SELECT orderid,
       dateid,
       countryid,
       categoryid,
       CAST(
           AES_DECRYPT(
               amount,
               UNHEX('e7826d5764b270b972617204cfe9331ab7d93968f16bb55bead11a3df3fb0128')
           ) AS CHAR
       ) AS amount
FROM FactSales
LIMIT 5;
