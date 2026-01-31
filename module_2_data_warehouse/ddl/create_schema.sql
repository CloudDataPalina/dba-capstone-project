-- Create schema for Data Warehouse (manual / step-by-step)
CREATE SCHEMA IF NOT EXISTS staging;
SET search_path TO staging;

-- =========================
-- Dimension tables
-- =========================
CREATE TABLE IF NOT EXISTS "DimDate" (
    dateid INTEGER PRIMARY KEY,
    fulldate DATE,
    day INTEGER,
    month INTEGER,
    monthname VARCHAR(20),
    year INTEGER,
    weekday VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS "DimCategory" (
    categoryid INTEGER PRIMARY KEY,
    categoryname VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS "DimCountry" (
    countryid INTEGER PRIMARY KEY,
    countryname VARCHAR(50)
);

-- Optional dimension (designed but not populated in this lab)
CREATE TABLE IF NOT EXISTS "DimItem" (
    itemid INTEGER PRIMARY KEY,
    itemname VARCHAR(100),
    price NUMERIC(10,2)
);

-- =========================
-- Fact table
-- =========================
CREATE TABLE IF NOT EXISTS "FactSales" (
    salesid INTEGER PRIMARY KEY,
    dateid INTEGER,
    categoryid INTEGER,
    countryid INTEGER,
    itemid INTEGER,
    price NUMERIC(10,2),
    quantity INTEGER
);

-- =========================
-- Constraints (optional, safe for re-runs)
-- =========================
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_fact_date') THEN
        ALTER TABLE "FactSales"
            ADD CONSTRAINT fk_fact_date
            FOREIGN KEY (dateid) REFERENCES "DimDate"(dateid) NOT VALID;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_fact_category') THEN
        ALTER TABLE "FactSales"
            ADD CONSTRAINT fk_fact_category
            FOREIGN KEY (categoryid) REFERENCES "DimCategory"(categoryid) NOT VALID;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_fact_country') THEN
        ALTER TABLE "FactSales"
            ADD CONSTRAINT fk_fact_country
            FOREIGN KEY (countryid) REFERENCES "DimCountry"(countryid) NOT VALID;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_fact_item') THEN
        ALTER TABLE "FactSales"
            ADD CONSTRAINT fk_fact_item
            FOREIGN KEY (itemid) REFERENCES "DimItem"(itemid) NOT VALID;
    END IF;
END $$;




