-- Create schema for Data Warehouse
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

-- Optional dimension (designed but not populated)
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
-- Constraints (optional)
-- =========================
ALTER TABLE "FactSales"
    ADD CONSTRAINT fk_fact_date FOREIGN KEY (dateid) REFERENCES "DimDate"(dateid);

ALTER TABLE "FactSales"
    ADD CONSTRAINT fk_fact_category FOREIGN KEY (categoryid) REFERENCES "DimCategory"(categoryid);

ALTER TABLE "FactSales"
    ADD CONSTRAINT fk_fact_country FOREIGN KEY (countryid) REFERENCES "DimCountry"(countryid);

-- DimItem optional
ALTER TABLE "FactSales"
    ADD CONSTRAINT fk_fact_item FOREIGN KEY (itemid) REFERENCES "DimItem"(itemid);



