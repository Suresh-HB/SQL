/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the death percentage locally and globally

*/


--Death percentage Globally

select * from  covid19cleancomplete;

SELECT Country_Region,
       SUM(CAST(Confirmed AS INT)) AS Total_Confirmed,
       SUM(CAST(Deaths AS INT)) AS Total_Deaths,
       ROUND((SUM(CAST(Deaths AS INT)) * 100.0) / SUM(CAST(Confirmed AS INT)),2) AS Death_percentage_globally
FROM covid19cleancomplete
GROUP BY Country_Region;


-- Death Percentage Locally 

SELECT * FROM covid19india;

SELECT State_UnionTerritory,
       SUM(CAST(Confirmed AS INT)) AS Total_Confirmed,
       SUM(CAST(Deaths AS INT)) AS Total_Deaths,
       (SUM(CAST(Deaths AS INT)) * 100.0) / SUM(CAST(Confirmed AS INT)) AS Death_percentageLocally
FROM covid19india
GROUP BY State_UnionTerritory;
