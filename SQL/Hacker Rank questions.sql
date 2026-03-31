-- Hacker Rank questions
-- EASY DIFFICULT
-- Revising the Select Query I
-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
SELECT * FROM City WHERE Population > 100000 AND Countrycode = "USA";

-- Revising the Select Query II
SELECT Name FROM City
WHERE Population > 120000 AND Countrycode = "USA";

-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;

-- Select By ID
SELECT * FROM CITY
WHERE ID = 1661;

-- Japanese Cities' Attributes
SELECT * FROM City
WHERE Countrycode = "JPN";

-- Japanese Cities' Names
SELECT Name FROM City
WHERE Countrycode = "JPN";

-- Weather Observation Station 1
SELECT City, State 
FROM Station;

-- Weather Observation Station 3
SELECT DISTINCT City 
FROM STATION
WHERE (ID%2) = 0;

-- Weather Observation Station 4
SELECT COUNT(City) - COUNT(DISTINCT City)
FROM Station;

-- Weather Observation Station 5
SELECT City, LENGTH(city) AS MIN_Value
FROM Station
ORDER BY LENGTH(city) ASC, city ASC
LIMIT 1;

SELECT City, LENGTH(city) AS MAX_Value
FROM Station
ORDER BY LENGTH(city) DESC, city DESC
LIMIT 1;

-- Weather Observation Station 6
SELECT DISTINCT city
FROM Station
WHERE city LIKE "a%" OR  city LIKE "e%" OR city LIKE "i%" OR city LIKE "o%" OR city LIKE "u%"

-- Weather Observation Station 7
SELECT DISTINCT city
FROM Station
WHERE city LIKE "%a" OR city LIKE "%e" OR city LIKE "%i" OR city LIKE "%o" OR city LIKE "%u";

-- Weather Observation Station 8
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ('A','E','I','O','U')
  AND RIGHT(CITY,1) IN ('A','E','I','O','U');

-- Weather Observation Station 9
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U');

-- Weather Observation Station 10
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('A','E','I','O','U');

-- Weather Observation Station 11
SELECT DISTINCT City
FROM Station
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') OR
RIGHT(CITY,1) NOT IN ('A','E','I','O','U');

-- Weather Observation Station 12
SELECT DISTINCT City
FROM Station
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') AND
RIGHT(CITY,1) NOT IN ('A','E','I','O','U');

-- Higher Than 75 Marks
SELECT Name
FROM Students
WHERE Marks > 75
ORDER BY RIGHT(Name,3) ASC, ID ASC;

-- Employee Names
SELECT name
FROM Employee
ORDER BY name ASC;

-- Employee Salaries
SELECT name FROM Employee
WHERE salary > 2000 
AND months <10
ORDER BY employee_id ASC;

--Another Level 
-- Weather Observation Station 15
SELECT ROUND(Long_w,4)
FROM Station 
WHERE Lat_n =(SELECT MAX(Lat_n) 
FROM Station WHERE Lat_n < 137.2345);

-- Weather Observation Station 16
SELECT ROUND(Lat_n,4)
FROM Station
WHERE Lat_n = (SELECT MIN(Lat_n)
FROM Station 
WHERE Lat_n > 38.7780);

-- Weather Observation Station 17
SELECT ROUND(Long_w,4)
FROM Station
WHERE Lat_n = (SELECT MIN(Lat_n)
FROM Station
WHERE Lat_n > 38.7780);


-- Weather Observation Station 18
SELECT ROUND ((MAX(Long_W) - MIN(Long_W)) + (MAX(Lat_n) - MIN(Lat_n)),4)
FROM Station;

-- Weather Observation Station 19
SELECT ROUND(
    SQRT(
        POW(MAX(LAT_N) - MIN(LAT_N), 2) +
        POW(MAX(LONG_W) - MIN(LONG_W), 2)
    ), 
4)
FROM STATION;





