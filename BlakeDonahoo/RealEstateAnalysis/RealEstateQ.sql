/*Blake Donahoo June 20, 2021 
Analysis of Single Family Residences in the United States from January 1996 to May 2021.
A few basic calculations on the "RealEstate" Database I created with *.CSV files downloaded from https://www.zillow.com/research/data/ .
In preparation for further data manipulation in Jupyter Notebooks and PowerBi/DAX:::

Basic questions and expectations one might ask themselves when reviewing the data:
1) What are the current Top and Bottom Tier Single family residence sales prices as of May of 2021?
2) How big is the gap between the two Tiers?
3) What is the average sales price for any home within the United States?
4) What percentage of change can we see from the earliest data we have to the present (01/1996 - 05/2021)?

5) What is the average change per year that can be observed from the data? 
	avg(high) & avg(low)
5.2) What is the average aggregated change per year? 
	AVG(avg(high),avg(low))

) Create new data table for a (High & Low) price prediction (In any city in the USA) in May 2022 (One Year Forecast) 
	INCLUDING: AverageChangePerYear
*/

--Top Tier and Bottom Tier sales price of a single family residence (SFR) in Texas in May of 2021
--1) What are the current Top and Bottom Tier Single family residence sales prices as of May of 2021?
SELECT T.StateName, T.may2021 AS 'Top Tier'	
FROM avgSalesPriceMOtopTier AS T 
WHERE T.StateName LIKE 'Texas' 
------
SELECT B.StateName, B.may2021 AS 'Bottom Tier'	
FROM avgSalesPriceMObotTier AS B
WHERE B.StateName LIKE 'Texas'
/*
														StateName                                          Top Tier
														-------------------------------------------------- ---------------------------------------
														Texas                                              425969

														(1 row affected)

														StateName                                          Bottom Tier
														-------------------------------------------------- ---------------------------------------
														Texas                                              142658

														(1 row affected)
*/
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--Percentage of the Top Tier that the Bottom Tier represents >> (State and National level)
--2) How big is the gap between the two Tiers?
SELECT avg(B.may2021 / (T.may2021/100)) AS ' Average Percentage Difference'
FROM avgSalesPriceMObotTier AS B, avgSalesPriceMOtopTier AS T
WHERE B.StateName LIKE 'Texas'

--SELECT avg(T.may2021-B.may2021) / (avg(T.may2021)/100) AS ' Average Percentage Difference'
--FROM avgSalesPriceMObotTier AS B, avgSalesPriceMOtopTier AS T

/* 
											 Average Percentage Difference			<< (Between Top & Bottom Tier Single Family Residences in Texas)
											---------------------------------------
											33.44022927261284

											(1 row affected)
----------------------------------------
							SANITY CHECK>>					RAW TEXAS STATE PERCENTAGE DIFFERENCE = 33.49%
															142658  =    x   
															-------   ------
															425969  =   100

															425969(X)=14265800 = 33.49%
*/
SELECT avg(B.may2021) AS ' Average National May2021 Low'
FROM avgSalesPriceMObotTier AS B
/*
															 Average National May2021 Low
															---------------------------------------
															184447.490196

															(1 row affected)
*/
SELECT avg(T.may2021) AS ' Average National May2021 High'
FROM avgSalesPriceMOtopTier AS T
/*
															 Average National May2021 High
															---------------------------------------
															499001.254901

															(1 row affected)
*/


SELECT (avg(B.may2021)*100) / avg(T.may2021) AS ' Average National Percentage Difference'
FROM avgSalesPriceMObotTier AS B, avgSalesPriceMOtopTier AS T
/*
															 Average National Percentage Difference = 36.96%		<< (Between Top & Bottom Tier Single Family Residences Nationally)
															---------------------------------------
															36.963331

															(1 row affected)

							SANITY CHECK>>					RAW NATIONAL PERCENTAGE DIFFERENCE = 
															184447.49  =    x   
															-------       ------
															499001.25  =   100

															499001.25(X)=18444749 = 36.96%
*/
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--Average sales price of a SFR in the United States in May of 2021
--3) What is the average sales price for any home within the United States?
SELECT AVG(T.may2021+B.may2021)/2 AS AverageSalesPrice
FROM avgSalesPriceMOtopTier AS T, avgSalesPriceMObotTier AS B
--WHERE T.StateName LIKE 'Texas'
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Just a note to myself for further calculations:::
-- int to multiply avg sales price by
SELECT avg(ForecastPct)/100 AS 'Multipy by this'
FROM ForecastCity AS F
----------------------------------------------------
--Create new table for Forecasted Average sales price of a **TOP tier SFR in the US in May of 2022
--CREATE TABLE ForecastAvgCitySFR

SELECT T.may2021 + (SELECT avg(ForecastPct)/100
						FROM ForecastCity AS F
						WHERE F.Lstate LIKE 'TX') 
						* T.may2021
		AS 'HighProjectedPrice2022', CityName
--INTO ForecastAvgCitySFR
From ForecastCity, avgSalesPriceMOtopTier AS T
--WHERE ForecastCity.Lstate LIKE 'TX'
ORDER BY CityName ASC;

--Forecasted Average sales price of a **BOTTOM tier SFR in the US in May of 2022
SELECT B.may2021 + (SELECT avg(ForecastPct)/100
						FROM ForecastCity AS F
						WHERE F.Lstate LIKE 'TX') 
						* B.may2021
		AS 'LowProjectedPrice2022', CityName
From ForecastCity, avgSalesPriceMObotTier AS B
ORDER BY CityName ASC;
	
---------------------------------------------------
--4) What percentage of change can we see from the earliest data we have to the present (01/1996 - 05/2021)?

SELECT AVG(T.may2021+B.may2021) - AVG(T.jan1996+B.jan1996) AS AverageSalesPriceDifference
FROM avgSalesPriceMOtopTier AS T, avgSalesPriceMObotTier AS B
/*
AverageSalesPriceDifference
---------------------------------------
436113.137255

(1 row affected)
*/
SELECT (AVG(T.may2021+B.may2021) - AVG(T.jan1996+B.jan1996)) / (AVG(T.may2021+B.may2021)/100) AS AverageSalesPriceDifferencePercentage
FROM avgSalesPriceMOtopTier AS T, avgSalesPriceMObotTier AS B
/*
AverageSalesPriceDifferencePercentage
---------------------------------------
63.810657

(1 row affected)
*/
