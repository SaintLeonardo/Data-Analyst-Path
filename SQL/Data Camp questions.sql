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

-- 