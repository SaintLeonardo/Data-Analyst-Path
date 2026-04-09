-- Data Camp questions JOINS
-- Perform an inner join with the cities table on the left and the countries table on the right; you do not need to alias tables here.
-- Join ON the country_code and code columns, making sure you identify them with the correct table.

SELECT * 
FROM cities
JOIN countries ON cities.country_code = countries.code;

-- Complete the SELECT statement to keep three columns: the name of the city, the name of the country, and the region the country is located in (in this order).
-- Alias the name of the city AS city and the name of the country AS country

SELECT cities.name AS city, countries.name AS country, countries.region
FROM cities 
INNER JOIN countries 
ON cities.country_code = countries.code;

-- Start with your inner join in line 5; join the tables countries AS c (left) with economies (right), aliasing economies AS e.
-- Next, use code as your joining field in line 7; do not use the USING command here.
-- Lastly, select the following columns in order in line 2: code from the countries table (aliased as country_code), name, year, and inflation_rate.

-- Select fields with aliases
SELECT c.code AS country_code, name, year, e.inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e  
-- Match on code field using table aliases
ON c.code = e.code

-- Use the country code field to complete the INNER JOIN with USING; do not change any alias names
SELECT c.name AS country, l.name AS language, official
FROM countries AS c
INNER JOIN languages AS l
-- Match using the code column
USING (code);

-- Now add an alias c for the countries table and perform an inner join with the languages table, l, on the right; join on code in line 8 with the USING keyword; include the language name, aliased as language.
-- Select country and language names (aliased)
SELECT c.name AS country, l.name AS language
-- From countries (aliased)
FROM countries c
-- Join to languages (aliased)
INNER JOIN languages AS l
-- Use code as the joining field with the USING keyword
USING (code);

--Add a WHERE clause to find how many countries speak the language 'Bhojpuri'
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
-- Filter for the Bhojpuri language
WHERE l.name = 'Bhojpuri';


-- Do an inner join of countries AS c (left) with populations AS p (right), on code.
-- Select name and fertility_rate.
SELECT c.name, p.fertility_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code;

-- Multiple JOINS
-- Chain an inner join with the economies table AS e, on code.
-- Select year and unemployment_rate from the economies table.
SELECT name, e.year, fertility_rate, e.unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code;

-- Modify your query so that you are joining to economies on year as well as code
SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
	AND e.year = p.year;

-- Inner Join
--Perform an inner join with cities AS c1 on the left and countries as c2 on the right.
-- Use code as the field to merge your tables on.
SELECT 
    c1.name AS city,
    code,
    c2.name AS country,
    region,
    city_proper_pop
FROM cities AS c1
INNER JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code DESC;

-- Complete the LEFT JOIN with the countries table on the left and the economies table on the right on the code field.
-- Filter the records from the year 2010.
SELECT name, region, gdp_percapita
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010;

-- To calculate per capita GDP per region, begin by grouping by region.
-- After your GROUP BY, choose region in your SELECT statement, followed by average GDP per capita using the AVG() function, with AS avg_gdp as your alias.
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
GROUP BY region;

-- Order the result set by the average GDP per capita from highest to lowest.
-- Return only the first 10 records in your result.
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
GROUP BY region
ORDER BY avg_gdp DESC
LIMIT 10;

-- Full Join
-- Perform a full join with countries (left) and currencies (right).
-- Filter for the North America region or NULL country names.
SELECT name AS country, code, region, basic_unit
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR name IS NULL
ORDER BY region;

-- Complete the FULL JOIN with countries as c1 on the left and languages as l on the right, using code to perform this join.
-- Next, chain this join with another FULL JOIN, placing currencies on the right, joining on code again.
SELECT 
	c1.name AS country, 
    region, 
    l.name AS language,
	basic_unit, 
    frac_unit
FROM countries as c1 
FULL JOIN languages AS l
ON c1.code = l.code
FULL JOIN currencies AS c2
ON c1.code = c2.code
WHERE region LIKE 'M%esia';


-- CROSS JOIN
-- Returned duplicate rows
SELECT c.name AS country, l.name AS language
FROM countries AS c        
CROSS JOIN languages AS l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');

-- Complete the join of countries AS c with populations as p.
-- Filter on the year 2010.
-- Sort your results by life expectancy in ascending order.
-- Limit the result to five countries.


-- SELF JOIN
-- Perform an inner join of populations with itself ON country_code, aliased p1 and p2 respectively.
-- Select the country_code from p1 and the size field from both p1 and p2, aliasing p1.size as size2010 and p2.size as size2015 (in that order).
-- Select aliased fields from populations as p1
SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code;

-- UNION and UNION ALL
-- Begin your query by selecting all fields from economies2015.
-- Create a second query that selects all fields from economies2019.
-- Perform a set operation to combine the two queries you just created, ensuring you do not return duplicates.
SELECT * 
FROM economies2015    
UNION
SELECT *
FROM economies2019
ORDER BY code, year;

-- Perform an appropriate set operation that determines all pairs of country code and year (in that order) from economies and populations, excluding duplicates.
-- Order by country code and year.
-- Query that determines all pairs of code and year from economies and populations, without duplicates
SELECT country_code, year
FROM populations
UNION
SELECT code, year
FROM economies
ORDER BY country_code, year;

-- INTERSECT
-- Return all cities with the same name as a country
SELECT name
FROM countries 
INTERSECT 
SELECT name
FROM cities;

-- EXCEPT
-- Return all cities that do not have the same name as a country
SELECT name
FROM cities
EXCEPT
SELECT name
FROM countries
ORDER BY name;

-- SEMI JOIN
-- Create a semi join out of the two queries you've written, which filters unique languages returned in the first query for only those languages spoken in the 'Middle East'.
SELECT DISTINCT name
FROM languages
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;

-- ANTI JOIN
SELECT code, name
FROM countries
WHERE continent = 'Oceania'
  AND code NOT IN
    (SELECT code
    FROM currencies);

-- Filter for only those populations where life expectancy is 1.15 times higher than average
SELECT *
FROM populations
WHERE year = 2015
  AND life_expectancy > 1.15 *
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);  

-- Filter for largest urbanarea population in capital
SELECT name, country_code, urbanarea_pop
FROM cities
WHERE name IN
    (SELECT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;

-- Write a LEFT JOIN with countries on the left and the cities on the right, joining on country code.
--In the SELECT statement of your join, include country names as country, and count the cities in each country, aliased as cities_num.
-- Sort by cities_num (descending), and country (ascending), limiting to the first nine records.
-- Find top nine countries with the most cities
SELECT co.name AS country,
COUNT(ci.country_code) AS cities_num
FROM countries AS co
LEFT JOIN cities AS ci
ON co.code = ci.country_code
GROUP BY country
ORDER BY cities_num DESC
LIMIT 9;

---- Subquery that provides the count of cities   
SELECT countries.name AS country,   
  (SELECT COUNT(cities.name)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;                                                                                                

-- Another day
-- FROM SUBQUERIES
SELECT local_name, sub.lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
WHERE countries.code = sub.code
ORDER BY lang_num DESC;

--Subquery Challenge
-- Select country code, inflation_rate, and unemployment_rate from economies.
-- Filter code for the set of countries which contain the words "Republic" or "Monarchy" in their gov_form.
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code IN
	(SELECT code
  FROM countries
  WHERE  gov_form LIKE
  '%Republic%' OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;

-- Final Challenge
-- From cities, select the city name, country code, proper population, and metro area population, as well as the field city_perc, which calculates the proper population as a percentage of metro area population for each city (using the formula provided).
-- Filter city name with a subquery that selects capital cities from countries in 'Europe' or continents with 'America' at the end of their name.
-- Exclude NULL values in metroarea_pop.
-- Order by city_perc (descending) and return only the first 10 rows.
-- Select fields from cities
SELECT name, country_code, city_proper_pop, metroarea_pop,
city_proper_pop/metroarea_pop * 100 AS city_perc
FROM cities
-- Use subquery to filter city name
WHERE name IN (
    SELECT capital
    FROM countries
    WHERE continent = 'Europe' OR
    continent LIKE '%America'
)
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC
LIMIT 10;


-- DATA MANIPULATION
-- CASE WHEN
-- Create a CASE statement that identifies whether a match in Germany included FC Bayern Munich, FC Schalke 04, or Other as the home team.
SELECT 
	CASE WHEN hometeam_id = 10189 THEN 'FC Schalke 04'
        WHEN hometeam_id = 9823 THEN 'FC Bayern Munich'
         ELSE 'Other' END AS home_team,
	COUNT(id) AS total_matches
FROM matches_germany
GROUP BY home_team;

-- Create a CASE statement to identify matches as home wins, home losses, or else ties.
SELECT 
	date,
	-- Identify home wins, losses, or ties
	CASE WHEN home_goal > away_goal THEN 'Home win!'
        WHEN home_goal < away_goal THEN 'Home loss :(' 
        ELSE 'Tie' END AS outcome
FROM matches_spain;

-- Complete the CASE statement to identify Barcelona's away team games as wins, losses, or ties.
-- Left join the teams_spain table team_api_id column on the matches_spain table hometeam_id column. This retrieves the identity of the home team opponent.
-- Filter the query to only include matches where Barcelona (awayteam_id = 8634) was the away team.
-- Select matches where Barcelona was the away team
SELECT  
	m.date,
	t.team_long_name AS opponent,
	CASE WHEN home_goal < away_goal THEN 'Barcelona win!'
        WHEN home_goal > away_goal THEN 'Barcelona loss :(' 
        ELSE 'Tie' END AS outcome
FROM matches_spain AS m
LEFT JOIN teams_spain AS t 
ON m.hometeam_id = t.team_api_id
WHERE m.awayteam_id = 8634;