BEGIN;

-- Optional cleanup to allow re-running the script
TRUNCATE TABLE
    public."FactSales",
    public."DimDate",
    public."DimCountry",
    public."DimCategory"
RESTART IDENTITY;

-- =========================
-- Load dimension tables
-- =========================

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

-- =========================
-- Load fact table
-- =========================

COPY public."FactSales" (
    orderid, dateid, countryid, categoryid, amount
)
FROM '/var/lib/pgadmin/FactSales.csv'
DELIMITER ','
CSV HEADER;

COMMIT;
