/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out the percentage of different vaccine taken by people in a country

*/

--To find out the percentage of different vaccine taken by people in a state

select * from covidvaccinestatewise;

SELECT 
    Updated_On AS Date,
    State,
    Covaxin_Doses_Administered * 100.0 / Total_Doses_Administered AS [Covaxin_Percentage],
    CoviShield_Doses_Administered * 100.0 / Total_Doses_Administered AS [CoviShield_Percentage],
    Sputnik_V_Doses_Administered * 100.0 / Total_Doses_Administered AS [Sputnik_V_Percentage] 
FROM 
    covidvaccinestatewise
order by date ASC;