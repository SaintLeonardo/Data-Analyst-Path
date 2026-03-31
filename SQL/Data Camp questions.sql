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

-- 

