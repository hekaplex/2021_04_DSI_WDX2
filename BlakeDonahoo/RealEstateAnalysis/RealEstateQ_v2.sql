/*
RealEstateQ_v2.sql

Blake Donahoo June 25, 2021 
Analysis of Single Family Residences in the United States from January 1996 to May 2021.
A few basic calculations on the "RealEstate" Database I created with *.CSV files downloaded from https://www.zillow.com/research/data/ .
In preparation for further data manipulation in Jupyter Notebooks and PowerBi/DAX:::

*** Key difference between v1 and v2 is the addition of the "avgSalesPriceMOmidTier" table as well as Pivoted versions of all three main tables (bottom,mid,top).
    I expect the addition of the middle tier to have a profound effect on the mathematical accuracy of the calculations.
	The edition of the Un-pivoted versions of the avgSalesPrice tables will give me another angle to perform more meaningful calculations as well. 

*** ABOUT THE RAW DATA
    Each of the three avgSalesPrice tables (Pre-Unpivoted) are 309 Columns with 52 Rows 
	TopTier & BottomTier UnPivAvgSalesPrice tables are 7 columns with 15,332 rows and MidTier is 7 columns with 3,600 rows
	ForecastCity consists of 6 columns and 30,557 rows


Basic questions and expectations one might ask themselves when reviewing the data:
1) What are is the average Top, Middle & Bottom Tier Single family residence sales price over the entire scale of time that is available?
2) How big is the gap between the three Tiers? *** (percentage change over time)
3) What is the average sales price for any home within the United States as of May 2021?
4) What percentage of change can we see from the earliest data we have to the present (01/1996 - 05/2021)?
4.2) How clean is the data? Are we missing any chunks from anywhere on any dataset? 
5) What is the average change per year that can be observed from the data? *** avg(high) | avg(mid) | avg(low)
5.2) What is the average aggregated change per year? *** AVG(avg(high),avg(mid),avg(low))

6) Create new data table for a (High | Mid | Low) price prediction (In any city in the USA) in May 2022 (One Year Forecast) *** INCLUDING: AverageChangePerYear
*/

-- All 3 unPivoted tables combined
-- StateName | State | Date | Bottom Tier | Mid Tier | Top Tier 
SELECT B.StateName
		, B.Lstate AS 'State'
		, B.Month + ' ' + B.Year AS 'Date'
		--, B.Month
		--, B.Year
		, B.Value AS 'Bottom Tier'
		, M.Value AS 'Mid Tier'
		, T.Value AS 'Top Tier'
--INTO AllThree_Unpiv
FROM UnPivAvgSalesPriceMoBotTier AS B
	JOIN UnPivAvgSalesPriceMoMidTier AS M
	ON B.StateName = M.StateName
	AND B.Lstate = M.Lstate
	AND B.Year = M.Year
	AND B.Month = M.Month
	JOIN UnPivAvgSalesPriceMoTOPTier AS T
	ON M.StateName = T.StateName
	AND M.Lstate = T.Lstate
	AND M.Year = T.Year
	AND M.Month = T.Month
ORDER BY B.StateName, B.Lstate
-------------

-- Top and Bottom Tier unPivoted tables combined
-- StateName | State | Month | Year | Bottom Tier | Top Tier 

SELECT B.StateName
		, B.Lstate AS 'State'
		, B.Month
		, B.Year
		, B.Value AS 'Bottom Tier'
		, T.Value AS 'Top Tier'
--INTO TopAndBottom_Unpiv
FROM UnPivAvgSalesPriceMoBotTier AS B
	JOIN UnPivAvgSalesPriceMoTOPTier AS T
	ON B.StateName = T.StateName
	AND B.Lstate = T.Lstate
	AND B.Year = T.Year
	AND B.Month = T.Month
ORDER BY B.StateName, B.Lstate





SELECT *
FROM TopAndBottom_Unpiv
----------------
-- National Bottom Tier Projection for 2022 by city
SELECT 
	(SELECT 
		AVG(B.Value) 
		FROM UnPivAvgSalesPriceMoBotTier AS B
	)
	* 
	(1+ AVG(ForecastPct)/100) AS 'NationalProjectedBottomTier2022' 
	,F.CityName
	,F.Lstate AS 'State'
FROM ForecastCity AS F 
	JOIN UnPivAvgSalesPriceMoBotTier AS B
ON F.Lstate = B.Lstate
GROUP BY F.CityName, F.Lstate
ORDER BY NationalProjectedBottomTier2022 ASC

-- National Middle Tier Projection for 2022 by city
SELECT 
	(SELECT 
		AVG(M.Value) 
		FROM UnPivAvgSalesPriceMoMidTier AS M
	)
	* 
	(1+ AVG(ForecastPct)/100) AS 'NationalProjectedMiddleTier2022' 
	,F.CityName
	,F.Lstate AS 'State'
FROM ForecastCity AS F 
	JOIN UnPivAvgSalesPriceMoMidTier AS M
ON F.Lstate = M.Lstate
GROUP BY F.CityName, F.Lstate
ORDER BY NationalProjectedMiddleTier2022 ASC

-- National Top Tier Projection for 2022 by city
SELECT 
	(SELECT 
		AVG(T.Value) 
		FROM UnPivAvgSalesPriceMoTopTier AS T
	)
	* 
	(1+ AVG(ForecastPct)/100) AS 'NationalProjectedTopTier2022' 
	,F.CityName
	,F.Lstate AS 'State'
FROM ForecastCity AS F 
	JOIN UnPivAvgSalesPriceMoTopTier AS T
ON F.Lstate = T.Lstate
GROUP BY F.CityName, F.Lstate
ORDER BY NationalProjectedTopTier2022 ASC

-- Combination of all three tables from above  
-- State | CityName | BottomTierProjection2022 | MiddleTierProjection2022 | TopTierProjection2022


WITH X AS (SELECT
				(SELECT
						AVG(B.Value)
						FROM UnPivAvgSalesPriceMoBotTier AS B
				)
				*
				(1+ AVG(ForecastPct)/100) AS 'BottomTierProjection2022'
				,F.CityName
				,F.Lstate AS 'State'
			FROM ForecastCity AS F 
				JOIN UnPivAvgSalesPriceMoBotTier AS B
			ON F.Lstate = B.Lstate
			GROUP BY F.CityName, F.Lstate
			)
,
Y AS (SELECT
				(SELECT
						AVG(M.Value)
						FROM UnPivAvgSalesPriceMoMidTier AS M
				)
				*
				(1+ AVG(ForecastPct)/100) AS 'MiddleTierProjection2022'
				,F.CityName
				,F.Lstate AS 'State'
			FROM ForecastCity AS F 
				JOIN UnPivAvgSalesPriceMoMidTier AS M
			ON F.Lstate = M.Lstate
			GROUP BY F.CityName, F.Lstate
			)
,
Z AS (SELECT
				(SELECT
						AVG(T.Value)
						FROM UnPivAvgSalesPriceMoTopTier AS T
				)
				*
				(1+ AVG(ForecastPct)/100) AS 'TopTierProjection2022'
				,F.CityName
				,F.Lstate AS 'State'
			FROM ForecastCity AS F 
				JOIN UnPivAvgSalesPriceMoTopTier AS T
			ON F.Lstate = T.Lstate
			GROUP BY F.CityName, F.Lstate
			)
SELECT X.State
		, X.CityName
		, X.BottomTierProjection2022
		, Y.MiddleTierProjection2022
		, Z.TopTierProjection2022
--INTO Forecast2022byCity
FROM X 
	JOIN
	 Y
ON X.State = Y.State
	AND
	X.CityName = Y.CityName
	JOIN Z
ON Y.State = Z.State
	AND
	Y.CityName = Z.CityName
ORDER BY X.State DESC;
--------------------------------
-- Average projections for 2022 by state
SELECT *
FROM Forecast2022byCity 
-----
SELECT State	
		, CityName
		, (BottomTierProjection2022+MiddleTierProjection2022+TopTierProjection2022) / 3 AS 'AverageProjection2022'	
FROM Forecast2022byCity 
-------------
SELECT B.may2021 AS Bvalue
		, M.[May-21] AS Mvalue
		, T.may2021 AS Tvalue
FROM avgSalesPriceMObotTier AS B
	JOIN avgSalesPriceMOmidTier AS M
	ON B.RegionID = M.RegionID
	AND B.SizeRank = M.SizeRank
	AND B.StateName = M.StateName
	AND B.Lstate = M.Lstate
	JOIN avgSalesPriceMOtopTier AS T
	ON M.RegionID = T.RegionID
	AND M.SizeRank = T.SizeRank
	AND M.StateName = T.StateName
	AND M.Lstate = T.Lstate
-------------

SELECT *
FROM UnPivAvgSalesPriceMoBotTier

------------------------------

-- Avg difference between values in the same column (difference over time) BOTTOM TIER
-- Performed on the unpivoted tables 
-- ORIGINAL SCHEMA   RegionID | SizeRank | StateName | Lstate | Date | Value
-- NEW SCHEMA        StateName | Lstate | Date | Value | PriorMonth | DiffPrevMonth

SELECT StateName
		, Lstate
		, B.Date
		, Value
		, LAG(Value) 
			OVER(PARTITION BY Lstate ORDER BY B.Date) AS PriorMonth
		, Value - LAG(Value)
			OVER (PARTITION BY Lstate ORDER BY B.Date) AS DiffPrevMonth
--INTO WindowBottom
FROM UnPivAvgSalesPriceMoBotTier AS B
ORDER BY Lstate
		, B.Date
-----------------------------------------------------------------------------------
-- Avg difference between values in the same column (difference over time) TOP TIER
SELECT StateName
		, Lstate
		, T.Date
		, Value
		, LAG(Value) 
			OVER(PARTITION BY Lstate ORDER BY T.Date) AS PriorMonth
		, Value - LAG(Value)
			OVER (PARTITION BY Lstate ORDER BY T.Date) AS DiffPrevMonth
        , (Value - LAG(Value) OVER (PARTITION BY Lstate ORDER BY T.Date)) / Value AS PercentageChange
--INTO WindowTop
FROM UnPivAvgSalesPriceMoTopTier AS T
ORDER BY Lstate
		, T.Date
	
----------------------------------------------------------	


SELECT StateName
		, Lstate
		, Date
		, Value
		, PriorYear
		, DiffPrevYear / (Value/100) AS PercentageChange
FROM WindowBottom
ORDER BY Lstate
		, Date 
