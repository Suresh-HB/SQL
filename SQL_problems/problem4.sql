/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the countries and continents with the highest death counts

*/

--countries with the highest death counts

select * FROM covid19cleancomplete

SELECT Country_Region AS Countries,
       SUM(Deaths) AS Country_highest_Deaths
FROM covid19cleancomplete
GROUP BY Country_Region
ORDER BY Country_highest_Deaths DESC;


--continents with the highest death counts

select * FROM covid19cleancomplete

SELECT 
    WHO_Region AS Country,
    SUM(Deaths) AS continents_highest_Deaths
FROM covid19cleancomplete
GROUP BY WHO_Region
ORDER BY continents_highest_Deaths DESC;