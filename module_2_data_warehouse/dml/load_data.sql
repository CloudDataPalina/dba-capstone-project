BEGIN;

-- Optional: clear tables to allow reruns
-- If you have FKs enabled, truncate FactSales first or use CASCADE.
TRUNCATE TABLE
    public."FactSales",
    public."DimDate",
    public."DimCountry",
    public."DimCategory"
RESTART IDENTITY;

-- =========================================================
-- Option A (SN Labs / pgAdmin file path)
-- Works ONLY if the PostgreSQL server can access /var/lib/pgadmin/
-- =========================================================

COPY public."DimDate" (
    dateid, date, year, quarter, quartername,
    month, monthname, day, weekday, weekdayname
)
FROM '/var/lib/pgadmin/DimDate.csv'
DELIMITER ','
CSV HEADER;

COPY public."DimCategory" (categoryid, category)
FROM '/var/lib/pgadmin/DimCategory.csv'
DELIMITER ','
CSV HEADER;

COPY public."DimCountry" (countryid, country)
FROM '/var/lib/pgadmin/DimCountry.csv'
DELIMITER ','
CSV HEADER;

COPY public."FactSales" (orderid, dateid, countryid, categoryid, amount)
FROM '/var/lib/pgadmin/FactSales.csv'
DELIMITER ','
CSV HEADER;

COMMIT;

-- =========================================================
-- Option B (Local / psql)
-- Use this instead of Option A when COPY fails due to file access.
-- Run in psql (NOT in pgAdmin Query Tool):
--   \copy public."DimDate" (...) FROM 'data/DimDate.csv' CSV HEADER;
-- =========================================================

