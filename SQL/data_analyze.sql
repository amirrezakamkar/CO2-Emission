-- removing the rows which shows the data for the world and EU.
DELETE FROM fossil_co2_totals_by_country_clean
WHERE Country IN ('EU27', 'GLOBAL TOTAL');

DELETE FROM your_table_name
WHERE Country IN ('EU27', 'GLOBAL TOTAL');
-- Create a list of the 10 largest economies in 2021
WITH LargestEconomies AS (
    SELECT 'United States' AS Country
    UNION ALL SELECT 'China'
    UNION ALL SELECT 'Japan'
    UNION ALL SELECT 'Germany'
    UNION ALL SELECT 'United Kingdom'
    UNION ALL SELECT 'India'
    UNION ALL SELECT 'France'
    UNION ALL SELECT 'Italy'
    UNION ALL SELECT 'Canada'
    UNION ALL SELECT 'South Korea'
)

-- Calculate averages for 2021
SELECT
    AVG(CASE WHEN c.Country IN (SELECT Country FROM LargestEconomies) THEN `2021` ELSE NULL END) AS Top10_Avg_CO2_2021,
    AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM LargestEconomies) THEN `2021` ELSE NULL END) AS Non_Top10_Avg_CO2_2021
FROM
    fossil_co2_totals_by_country_clean c;
    
    -- Calculate averages for 1970
    
    WITH LargestEconomies AS (
    SELECT 'United States' AS Country
    UNION ALL SELECT 'China'
    UNION ALL SELECT 'Japan'
    UNION ALL SELECT 'Germany'
    UNION ALL SELECT 'United Kingdom'
    UNION ALL SELECT 'India'
    UNION ALL SELECT 'France'
    UNION ALL SELECT 'Italy'
    UNION ALL SELECT 'Canada'
    UNION ALL SELECT 'South Korea'
)

SELECT
    AVG(CASE WHEN c.Country IN (SELECT Country FROM LargestEconomies) THEN `1970` ELSE NULL END) AS Top10_Avg_CO2_2021,
    AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM LargestEconomies) THEN `1970` ELSE NULL END) AS Non_Top10_Avg_CO2_2021
FROM
    fossil_co2_totals_by_country_clean c;
    
-- Calculating the transport secton co2 emission in three years, 11 years apart each, to see if the new electric industery
-- had an effect or not.
SELECT
    AVG(`2021`) AS Avg_CO2_Transport_2021,
    AVG(`2010`) AS Avg_CO2_Transport_2010,
    AVG(`1999`) AS Avg_CO2_Transport_1999
FROM
    fossil_co2_by_sector_and_country_clean
WHERE
    Sector = 'Transport';
-- calculating the increase of co2 emission in transport industry
SELECT
    AVG(`2001`) AS Avg_CO2_Transport_2001,
    AVG(`2010`) AS Avg_CO2_Transport_2010,
    AVG(`2019`) AS Avg_CO2_Transport_2019,
    (AVG(`2010`) - AVG(`2001`)) / AVG(`2001`) * 100 AS Growth_2001_to_2010,
    (AVG(`2019`) - AVG(`2010`)) / AVG(`2010`) * 100 AS Growth_2010_to_2019
FROM
    fossil_co2_by_sector_and_country_clean
WHERE
    Sector = 'Transport';
-- calculating the increase of co2 emission in Power industry
SELECT
    AVG(`2001`) AS Avg_CO2_Power_Industry_2001,
    AVG(`2010`) AS Avg_CO2_Power_Industry_2010,
    AVG(`2019`) AS Avg_CO2_Power_Industry_2019,
    (AVG(`2010`) - AVG(`2001`)) / AVG(`2001`) * 100 AS Growth_2001_to_2010,
    (AVG(`2019`) - AVG(`2010`)) / AVG(`2010`) * 100 AS Growth_2010_to_2019
FROM
    fossil_co2_by_sector_and_country_clean
WHERE
    Sector = 'Power Industry';

-- checking for the increase in co2 emission in power industry for top 10 economies.
-- Define the top 10 GDP countries
WITH Top10GDP AS (
    SELECT 'United States' AS Country
    UNION ALL SELECT 'China'
    UNION ALL SELECT 'Japan'
    UNION ALL SELECT 'Germany'
    UNION ALL SELECT 'United Kingdom'
    UNION ALL SELECT 'India'
    UNION ALL SELECT 'France'
    UNION ALL SELECT 'Italy'
    UNION ALL SELECT 'Canada'
    UNION ALL SELECT 'South Korea'
)

-- Calculate averages and percentage increases
SELECT
    AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) AS Avg_CO2_Power_2001,
    AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) AS Avg_CO2_Power_2010,
    AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) AS Avg_CO2_Power_2019,
    (AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) -
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) * 100 AS Growth_2001_to_2010,
    (AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) -
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) * 100 AS Growth_2010_to_2019,
    (AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) -
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) * 100 AS Growth_2001_to_2019
FROM
    fossil_co2_by_sector_and_country_clean c
WHERE
    c.Sector = 'Power Industry';

-- checking for the increase in co2 emission in power industry for al countries except top 10 economies.
-- Define the top 10 GDP countries
WITH Top10GDP AS (
    SELECT 'United States' AS Country
    UNION ALL SELECT 'China'
    UNION ALL SELECT 'Japan'
    UNION ALL SELECT 'Germany'
    UNION ALL SELECT 'United Kingdom'
    UNION ALL SELECT 'India'
    UNION ALL SELECT 'France'
    UNION ALL SELECT 'Italy'
    UNION ALL SELECT 'Canada'
    UNION ALL SELECT 'South Korea'
)

-- Calculate averages and percentage increases for non-top 10 countries
SELECT
    AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) AS Avg_CO2_Power_2001,
    AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) AS Avg_CO2_Power_2010,
    AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) AS Avg_CO2_Power_2019,
    (AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) -
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) * 100 AS Growth_2001_to_2010,
    (AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) -
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2010` ELSE NULL END) * 100 AS Growth_2010_to_2019,
    (AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2019` ELSE NULL END) -
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END)) / 
     AVG(CASE WHEN c.Country NOT IN (SELECT Country FROM Top10GDP) THEN `2001` ELSE NULL END) * 100 AS Growth_2001_to_2019
FROM
    fossil_co2_by_sector_and_country_clean c
WHERE
    c.Sector = 'Power Industry';

    
