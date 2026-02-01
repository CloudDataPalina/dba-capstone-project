CREATE MATERIALIZED VIEW total_sales_per_country AS
SELECT c.country, SUM(f.amount) AS total_sales
FROM public."FactSales" f
JOIN public."DimCountry" c 
    ON f.countryid = c.countryid
GROUP BY c.country;
