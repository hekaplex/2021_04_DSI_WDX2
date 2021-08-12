/*
After building machine learning models with the set of rental data, I've realized that a good coefficient of determination cannot be obtained without 
using proxy variables. As a solution to this, I will be combining the rental dataset with the sales dataset and joining them where the dates match up 
and removing all proxy variables for both datasets in an effort to achieve a higher valid r2 scoring.
*/

SELECT *
FROM Rental_FullEDA

-- rental dataset date range = 2014-01-01 to 2021-05-01 //  We'll match the sales dataset to this date range. 
-- proxy columns = R_Annual, R_PriorMonth, R_60DayDiff, R_90DayDiff
-- non-proxy columns = R_Monthly, Lstate, CityName, Date, R_DiffPrevMonth, R_60DayChange, R_90DayChange

SELECT R_Monthly, Lstate, CityName, Date, R_DiffPrevMonth, R_60DayChange, R_90DayChange
--INTO Rental_NoProxies
FROM Rental_FullEDA
-- (9,419 rows)

--###########################################################################################


SELECT *
FROM SalesPrice_FullEDA2
-- (15,332 rows)
-- proxy columns =  B_PriorMonth, B_60DayDiff, B_90DayDiff, M_PriorMonth, M_60DayDiff, M_90DayDiff, T_PriorMonth, T_60DayDiff, T_90DayDiff
--                  B_AvgAnnual, M_AvgAnnual, T_AvgAnnual
-- useless columns = StateName
-- non-proxy columns = BottomTier, MiddleTier, TopTier, Lstate, Date, B_DiffPrevMonth, B_60DayChange, B_90DayChange
--                     M_DiffPrevMonth, M_60DayChange, M_90DayChange, T_DiffPrevMonth, T_60DayChange, T_90DayChange
--                     B_PrincipalMonthly, B_AvgMortgage, B_InterestMonthly, M_PrincipalMonthly, M_AvgMortgage, M_InterestMonthly  
--                     T_PrincipalMonthly, T_AvgMortgage, T_InterestMonthly

SELECT BottomTier, MiddleTier, TopTier, Lstate, S.Date, B_DiffPrevMonth, B_60DayChange, B_90DayChange
	, M_DiffPrevMonth, M_60DayChange, M_90DayChange, T_DiffPrevMonth, T_60DayChange, T_90DayChange
	, B_PrincipalMonthly, B_AvgMortgage, B_InterestMonthly, M_PrincipalMonthly, M_AvgMortgage, M_InterestMonthly
	, T_PrincipalMonthly, T_AvgMortgage, T_InterestMonthly
--INTO SalesPrice_DateRangeMatchToRental
FROM SalesPrice_FullEDA2 AS S
WHERE S.Date >= '2014-01-01' and S.Date <= '2021-05-01'
-- (4,539 rows)
--#############################################################################################

-- Now to Join our refined sales and rental tables

SELECT DISTINCT BottomTier, MiddleTier, TopTier, S.Lstate AS Lstate1
	, S.Date AS Date1, B_DiffPrevMonth, B_60DayChange, B_90DayChange
	, M_DiffPrevMonth, M_60DayChange, M_90DayChange, T_DiffPrevMonth
	, T_60DayChange, T_90DayChange, B_PrincipalMonthly, B_AvgMortgage
	, B_InterestMonthly, M_PrincipalMonthly, M_AvgMortgage, M_InterestMonthly
	, T_PrincipalMonthly, T_AvgMortgage, T_InterestMonthly, R_Monthly, R.Lstate
	, CityName, R.Date, R_DiffPrevMonth, R_60DayChange, R_90DayChange 
--INTO Combined_SalesAndRental
FROM SalesPrice_DateRangeMatchToRental AS S
	INNER JOIN 
	Rental_NoProxies AS R
	ON S.Date = R.Date 
	AND
	S.Lstate = R.Lstate 

-- (9,330 rows, 28 columns (after we drop the extra Lstate and Date column))
