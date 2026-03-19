
-- SQL BOLT Exercises 
-- Lesson 02
-- Select all movies released between 2000 and 2010
SELECT * FROM movies WHERE Year BETWEEN 2000 AND 2010;

-- Select all movies not released between 2000 and 2010
SELECT * FROM movies WHERE Year NOT BETWEEN 2000 AND 2010;

-- Find the first 5 Pixar movies and their release year
SELECT Title, Year FROM movies LIMIT 5; 

--Lesson 03
-- Find all the Toy Story movies 
SELECT * FROM movies WHERE Title LIKE 'Toy Story%';

--Find all the movies directed by John Lasseter
SELECT * FROM movies WHERE Director = 'John Lasseter';

--Find all the movies (and director) not directed by John Lasseter 
SELECT Title, Director FROM movies WHERE Director != 'John Lasseter';

--Find all the WALL-* movies 
SELECT * FROM movies WHERE Title LIKE 'WALL-%';

-- Lesson 04
-- List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT Director FROM movies ORDER BY Director;

--List the last four Pixar movies released (ordered from most recent to least) 
SELECT * FROM movies ORDER BY Year DESC LIMIT 4;

-- List the first five Pixar movies sorted alphabetically
SELECT * FROM movies ORDER BY Title ASC LIMIT 5;

-- List the next five Pixar movies sorted alphabetically
SELECT * FROM movies ORDER BY Title ASC LIMIT 5 OFFSET 5;

-- Lesson 05
-- List all the Canadian cities and their populations
SELECT City, Population FROM north_american_cities WHERE Country = 'Canada';

-- Order all the cities in the United States by their latitude from north to south 
SELECT City FROM north_american_cities WHERE Country = 'United States' ORDER BY Latitude DESC;

-- List all the cities west of Chicago, ordered from west to east
SELECT City FROM north_american_cities
WHERE Longitude < -87.629798
ORDER BY Longitude DESC;

-- List the two largest cities in Mexico (by population) 
SELECT City FROM north_american_cities
WHERE Country = 'Mexico'
ORDER BY Population DESC
LIMIT 2;

--List the third and fourth largest cities (by population) in the United States and their population
SELECT City, Population FROM north_american_cities
WHERE Country = 'United States'
ORDER BY Population DESC
LIMIT 2 OFFSET 2;

-- Lesson 06
-- Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales 
FROM movies
JOIN boxoffice ON movies.id = boxoffice.movie_id;

--Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title, domestic_sales, international_sales
FROM movies
JOIN boxoffice ON movies.id = boxoffice.movie_id
WHERE international_sales > domestic_sales;

-- List all the movies by their ratings in descending order
SELECT title, Rating
FROM movies
JOIN boxoffice ON movies.id = boxoffice.movie_id
ORDER BY Rating DESC;

-- Lesson 07
-- Find the list of all buildings that have employees
SELECT DISTINCT building FROM employees;

-- Find the list of all buildings and their capacity
SELECT Building_name, capacity FROM Buildings;

-- List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT building_name, role 
FROM buildings 
  LEFT JOIN employees
    ON building_name = employees.building_name

-- Lesson 08
-- Find the name and role of all employees who have not been assigned to a building
SELECT Name, Role FROM Employees
WHERE Building IS NULL;

-- Find the names of the buildings that hold no employees
SELECT DISTINCT Building_name 
FROM Buildings
LEFT JOIN Employees ON Building_name = building
WHERE Role IS NULL;

-- Lesson 09
-- List all movies and their combined sales in millions of dollars
SELECT Title, (Domestic_Sales + International_sales)/1000000 AS Total_of_Sales
FROM Movies
JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_ID;

--List all movies and their ratings in percent 
SELECT Title, Rating*10 AS Final_Rating
FROM Movies
JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_ID;

-- List all movies that were released on even number years
SELECT Title, Year, Year%2 AS Even_number_years
FROM Movies
JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_ID
WHERE Even_number_years = 0;

--Lesson 10
-- Find the longest time that an employee has been at the studio
SELECT Name, MAX(Years_employed) FROM employees;

-- For each role, find the average number of years employed by employees in that role
SELECT Role, AVG(Years_employed) AS Average_years_employed
FROM Employees
GROUP BY Role;

-- Find the total number of employee years worked in each building
SELECT Building, SUM(Years_Employed) as Average_years
FROM employees
GROUP BY Building;

-- Lesson 11
-- Find the number of Artists in the studio (without a HAVING clause) 
SELECT COUNT(*) FROM employees
WHERE Role = "Artist";

-- Find the number of Employees of each role in the studio
SELECT COUNT(*), Role
FROM employees
GROUP BY Role;

-- Find the total number of years employed by all Engineers
SELECT Role, SUM(years_employed)
FROM employees
GROUP BY role
HAVING role = "Engineers";

--Lesson 12
-- Find the number of movies each director has directed
SELECT Director, COUNT(Director) as Number_Of_Movies
FROM movies
GROUP BY Director;

-- Find the total domestic and international sales that can be attributed to each director
SELECT Director, SUM(Domestic_sales + International_sales)
FROM movies
JOIN Boxoffice ON Movies.ID = Boxoffice.Movie_ID
GROUP BY Director;

-- Lesson 13
-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
INSERT INTO movies (Title, Director, Year) 
VALUES ('Toy Story 4', 'John Lasseter', 2019);

--Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
INSERT INTO Boxoffice
(Movie_id,Rating, Domestic_sales, International_sales)
VALUES (16, 8.7, 340000000, 270000000);

-- Lesson 14
-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter 
UPDATE movies
SET Director = 'John Lasseter'
WHERE Title = "A Bug's Life";

-- The release year for Toy Story 2 is incorrect, it was actually released in 1999
UPDATE Movies
SET Year = 1999
WHERE Title = "Toy Story 2";

--Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE Movies
SET Title = "Toy Story 3",
Director = "Lee Unkrich"
WHERE Title = "Toy Story 8";

--Lesson 15
--This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM Movies
WHERE Year < 2005;

-- Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM Movies
WHERE Director = "Andrew Stanton";

-- Lesson 16
-- Create a new table named Database with the following columns:
-- Name A string (text) describing the name of the database
-- Version A number (floating point) of the latest version of this database
-- Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints. 
CREATE TABLE IF NOT EXISTS Database (
    Name TEXT,
    Version Float,
    Download_count INTEGER
);

-- Lesson 17
-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in. 
ALTER TABLE Movies
ADD COLUMN Aspect_ratio FLOAT;

-- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English
ALTER TABLE Movies
ADD COLUMN Language TEXT DEFAULT 'English';

--Lesson 18
-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE IF EXISTS Movies;

-- And drop the BoxOffice table as well\
DROP TABLE IF EXISTS Boxoffice;