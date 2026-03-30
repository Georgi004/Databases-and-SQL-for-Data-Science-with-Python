
-- 1. Analiza Genurilor (Top 3 castiguri totale) --
-- Identifica cele mai profitabile 3 genuri pe baza SUMEI totale a incasarilor (box_office). --
SELECT
	g.name AS genre_name,
    SUM(m.box_office) AS total_revenue
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_revenue DESC
LIMIT 3;

-- 2. Legatura dintre Buget si Castiguri --
-- Extrage bugetul si castigul (box_office) pentru filmele cu date valide (> 0) in vederea calcularii corelatiei si a crearii scatter plot-ului in Python. --
SELECT
	budget,
    box_office AS revenue
FROM movies
WHERE budget > 0 AND box_office > 0;

-- 3. Analiza Tarilor de Productie (Top 5 castig mediu)
-- Calculeaza Castigul Mediu (AVG(box_office)) pe film pentru fiecare tara si returneaza primele 5 tari cu cea mai mare medie.
SELECT
	c.name AS country_name,
    AVG(m.box_office) AS average_revenue
FROM movies m
JOIN movies_countries mc ON m.movie_id = mc.movie_id
JOIN countries c ON mc.country_id = c.country_id
WHERE m.box_office > 0
GROUP BY c.name
ORDER BY average_revenue DESC
LIMIT 5;

-- 4. Top 10 Filme dupa Castiguri (Revenue)
-- Identifica primele 10 filme dupa incasarile maxime (box_office).
-- NOTA: Se foloseste DISTINCT pentru a evita randurile duplicate in cazul in care un film apare de mai multe ori in tabela 'movies'.
SELECT DISTINCT
    title,
    box_office AS revenue
FROM movies
ORDER BY revenue DESC
LIMIT 10;

ALTER TABLE movies
DROP FOREIGN KEY movies_ibfk_2;

ALTER TABLE movies
DROP COLUMN country_id;

DESCRIBE movies;
SHOW TABLES;