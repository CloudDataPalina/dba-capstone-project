SELECT d.year, c.country, SUM(f.amount) AS totalsales
FROM public."FactSales" f
JOIN public."DimDate" d  ON f.dateid = d.dateid
JOIN public."DimCountry" c ON f.countryid = c.countryid
GROUP BY ROLLUP (d.year, c.country)
ORDER BY d.year, c.country;
