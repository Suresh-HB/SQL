/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the population vs the number of people vaccinated

*/

select * from worldometer_data;
select * from covidvaccinestatewise;

WITH HighestPopulationCTE AS (

    SELECT MAX(Population) AS HighestPopulation
    FROM worldometer_data
    WHERE Continent = 'Asia'
),



LatestDoses AS (

    SELECT Total_Doses_Administered
    FROM covidvaccinestatewise
    WHERE State = 'India' AND Updated_On = ( SELECT MAX(Updated_On)
                                             FROM covidvaccinestatewise
                                             WHERE State = 'India'
                                             AND Total_Doses_Administered IS NOT NULL
                                             )
    AND Total_Doses_Administered IS NOT NULL
    )

SELECT ROUND((ld.Total_Doses_Administered * 100.0) / hp.HighestPopulation, 2) AS Percentage
FROM LatestDoses ld
CROSS JOIN HighestPopulationCTE hp;