/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : Considering the highest value of total cases, which countries have the highest rate of infection in relation to population? 


*/

--which countries have the highest rate of infection

select * from worldometer_data;

WITH MaxTotalCases AS (
    SELECT MAX(TotalCases) AS MaxCases
    FROM dbo.worldometer_data
),
InfectionRates AS (
                    SELECT Country_Region AS Country,(TotalCases * 1.0 / Population) AS InfectionRate,TotalCases
                    FROM dbo.worldometer_data
					WHERE TotalCases = (SELECT MaxCases FROM MaxTotalCases)
                   )

SELECT Country,InfectionRate,TotalCases
FROM InfectionRates
ORDER BY InfectionRate DESC;