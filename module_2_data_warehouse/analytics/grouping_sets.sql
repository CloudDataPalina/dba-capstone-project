SELECT c.country, cat.category, SUM(f.amount) AS totalsales
FROM public."FactSales" f
JOIN public."DimCountry"  c   ON f.countryid  = c.countryid
JOIN public."DimCategory" cat ON f.categoryid = cat.categoryid
GROUP BY GROUPING SETS
(
    (c.country, cat.category),
    (c.country),
    (cat.category),
    ()
)
ORDER BY c.country, cat.category;
