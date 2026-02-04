-- ============================================
-- Lab 1: Database & Query Optimization
-- Module 5 – Database Optimization & Security
-- ============================================

-- Select database
USE sales;

-- --------------------------------------------
-- Step 1: Query execution BEFORE indexing
-- --------------------------------------------
SELECT * FROM FactSales
WHERE countryid = 50;

EXPLAIN
SELECT * FROM FactSales
WHERE countryid = 50;

-- --------------------------------------------
-- Step 2: Create index on countryid
-- --------------------------------------------
CREATE INDEX idx_countryid
ON FactSales(countryid);

-- Verify index creation
SHOW INDEX FROM FactSales;

-- --------------------------------------------
-- Step 3: Query execution AFTER indexing
-- --------------------------------------------
SELECT * FROM FactSales
WHERE countryid = 50;

EXPLAIN
SELECT * FROM FactSales
WHERE countryid = 50;

-- --------------------------------------------
-- Step 4: Optimize table storage
-- --------------------------------------------
OPTIMIZE TABLE DimDate;
