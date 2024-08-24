/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the countries with the highest infection rates

*/

--Highest infection rates

select * FROM covid19cleancomplete

SELECT 
    Country_Region,
    SUM(CAST(confirmed AS INT)) AS Total_Confirmed
FROM covid19cleancomplete
GROUP BY Country_Region
ORDER BY Total_Confirmed DESC;