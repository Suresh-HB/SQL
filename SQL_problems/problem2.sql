/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the infected population percentage locally and globally

*/



--infected globally

SELECT * FROM covid19cleancomplete

SELECT Country_Region,
       SUM(Confirmed) AS Total_Confirmed ,
	   SUM(Active) AS Total_Active,
	  (SUM(Active)*100.0)/SUM(Confirmed) AS Globally_Infected

FROM covid19cleancomplete
GROUP BY country_Region;


--infected locally

SELECT * FROM covid19india;

SELECT State_UnionTerritory,
       SUM(CAST(Confirmed AS INT)) AS Total_Confirmed ,
       SUM(CAST(Cured AS INT)) AS Total_Cured,
 (100-(SUM(CAST(Cured AS INT))*100.0)/SUM(CAST(Confirmed AS INT))) AS locally_Infected

FROM covid19india
GROUP BY State_UnionTerritory;