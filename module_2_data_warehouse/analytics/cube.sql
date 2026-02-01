SELECT d.year, c.country, AVG(f.amount) AS averagesales
FROM public."FactSales" f
JOIN public."DimDate" d 
    ON f.dateid = d.dateid
JOIN public."DimCountry" c 
    ON f.countryid = c.countryid
GROUP BY CUBE (d.year, c.country)
ORDER BY d.year, c.country;
