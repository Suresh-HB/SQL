/*
@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : To find out percentage of people who took both the doses

*/


--To find out percentage of people who took both the doses

select * from covidvaccinestatewise;

SELECT
    v.Updated_On AS Date,
    v.State,
    CASE 
        WHEN COALESCE(v.First_Dose_Administered, 0) = 0 THEN 0
        ELSE 
            (COALESCE(v.Second_Dose_Administered, 0) * 100.0 / COALESCE(v.First_Dose_Administered, 1))
    END AS [Percentage_Both_Doses]
FROM 
    covidvaccinestatewise v
JOIN 
    covidvaccinestatewise i
ON 
    v.State = i.State
WHERE
    v.Updated_On = i.Updated_On  
ORDER BY Date ASC;
