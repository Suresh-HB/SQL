/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : Average of cases divided by the number of population of each country (TOP 10) 

*/

-- Average of cases divided by the number of population of each country (TOP 10)

select * from dbo.worldometer_data;

SELECT TOP 10 
    Country_Region AS Country,
    AVG(Cases_Per_Population) AS Avg_Cases_Per_Population

FROM (
       SELECT Country_Region,(TotalCases * 1.0 / Population) AS Cases_Per_Population
       FROM dbo.worldometer_data
     ) AS CountryCases
GROUP BY Country_Region
ORDER BY Avg_Cases_Per_Population DESC;