USE movies_db;

-- 1. Interogare imbricata (SUBQUERY)
-- Filmele al caror buget este mai mare decat bugetul mediu al tuturor filmelor.
EXPLAIN
SELECT 
	title,
    budget
FROM movies WHERE budget > (
	SELECT AVG(budget) 
    FROM movies
)
ORDER BY budget DESC;

-- 2. Gruparea si Agregarea (GROUP BY si COUNT)
-- Prezentarea numarului de filme pentru fiecare tara.
EXPLAIN
SELECT 
	c.name AS CountryName,
    COUNT(m.movie_id) AS NumberOfMovies
FROM countries c
JOIN movies m ON c.country_id = m.country_id
GROUP BY c.name
ORDER BY NumberOfMovies DESC;

-- 3. Filtrarea Gruparilor (GROUP BY si HAVING)
-- Genurile care au mai mult de 5 filme in baza de date.
EXPLAIN
SELECT
	g.name AS GenreName, 
	COUNT(mg.movie_id) AS TotalFilms
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
GROUP BY g.name
HAVING COUNT(mg.movie_id) >= 2 
ORDER BY TotalFilms DESC;

-- 4. Sortare si limitare (ORDER BY si LIMIT)
-- Cele mai bune 10 filme cu cele mai mari incasari.
EXPLAIN
SELECT
	title,
    box_office
FROM movies
ORDER BY box_office DESC
LIMIT 10;

-- 5. Sortare si limitare (ORDER BY si LIMIT)
-- 5 filme care sunt cele mai scurte ca durata.
EXPLAIN
SELECT 
	title,
    duration
FROM movies
ORDER BY duration ASC 
LIMIT 5;

-- 6. Functie Agregata (SUM)
-- Calcularea venitului total (Box Office) al tuturor filmelor din baza de date.
EXPLAIN
SELECT 
	SUM(box_office) AS TotalBoxOffice
FROM movies;

-- 7. Functie Agregata (AVG)
-- Durata medie a tuturor filmelor.
EXPLAIN
SELECT
	AVG(duration) AS AverageDurationMinutes
FROM movies;

-- 8. Functii Agregate (MAX si MIN)
-- Cel mai scump si cel mai ieftin film dupa buget.
EXPLAIN
SELECT
	title AS MostExpensiveFilm,
	budget
FROM movies 
ORDER BY budget DESC
LIMIT 1;

-- 9. Functii Scalare (LENGTH si UPPER)
-- Prezentarea filmelor al caror titlu contine mai mult de 15 caractere si prezentarea cu litere mari.
EXPLAIN
SELECT 
	UPPER(title) AS LongTitleInUpperCase,
    LENGTH(title) AS TitleLength
FROM movies 
WHERE LENGTH(title) > 15
ORDER BY TitleLength DESC;

-- 10. Functie Scalara (SUBSTRING)
-- Prezentarea primelor 5 caractere din titlul tuturor filmelor.
EXPLAIN
SELECT
	title,
    SUBSTRING(title, 1, 5) AS TitlePrefix
FROM movies;