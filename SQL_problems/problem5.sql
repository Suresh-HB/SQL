/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : Average number of deaths by day (Continents and Countries) 

*/

--Countries with Average number of deaths by day

select * FROM covid19cleancomplete	

SELECT Country_Region AS Country,
    AVG(Daily_Deaths) AS Avg_Daily_Deaths

FROM (
      SELECT Country_Region,Date,SUM(Deaths) AS Daily_Deaths
      FROM covid19cleancomplete

      GROUP BY Country_Region, Date
      ) AS DailyDeaths

GROUP BY Country_Region
ORDER BY Avg_Daily_Deaths DESC;


--Continents  with Average number of deaths by day

SELECT WHO_Region AS Continent,
    AVG(Daily_Deaths) AS Avg_Daily_Deaths

FROM (
      SELECT WHO_Region,Date,SUM(Deaths) AS Daily_Deaths
      FROM covid19cleancomplete

      GROUP BY WHO_Region, Date
     ) AS DailyDeathsByContinent

GROUP BY WHO_Region
ORDER BY Avg_Daily_Deaths DESC;