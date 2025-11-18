USE movies_db;

-- Directors
INSERT INTO directors (name) VALUES
('Ridley Scott'),
('Denis Villeneuve'),
('Alfonso Cuarón'),
('Hayao Miyazaki'),
('Jean-Pierre Jeunet'),
('Jonathan Demme'),
('Damien Chazelle'),
('Park Chan-wook'),
('Ang Lee'),
('Peter Jackson'),
('Quentin Tarantino'),
('Greta Gerwig');

-- Countries
INSERT INTO countries (name) VALUES
('USA'),
('Canada'),
('UK'),
('Japan'),
('France'),
('South Korea'),
('New Zealand'),
('Germany'),
('Spain'),
('Australia');

-- Languages
INSERT INTO languages (name) VALUES 
('English'),
('French'),
('Japanese'),
('Korean'),
('Spanish'),
('German'),
('Italian'),
('Mandarin'),
('Hindi'),
('Russian');

-- Genres
INSERT INTO genres (name) VALUES 
('Sci-Fi'),
('Adventure'),
('Drama'),
('Thriller'),
('Animation'),
('Fantasy'),
('Romance'),
('Comedy'),
('Crime'),
('Mystery');

-- Movies
INSERT INTO movies (title, year, duration, budget, box_office, director_id, country_id, language_id) VALUES
('The Martian', 2015, 144, 108000000.00, 630161890.00, 1, 1, 1),        -- Ridley Scott (1), USA (1), English (1)
('Arrival', 2016, 118, 47000000.00, 203388186.00, 2, 2, 1),            -- Denis Villeneuve (2), Canada (2), English (1)
('Gravity', 2013, 91, 100000000.00, 723192705.00, 3, 3, 1),            -- Alfonso Cuarón (3), UK (3), English (1)
('Spirited Away', 2001, 125, 20000000.00, 395804555.00, 4, 4, 3),      -- Hayao Miyazaki (4), Japan (4), Japanese (3)
('Amelie', 2001, 122, 11000000.00, 174208000.00, 5, 5, 2),             -- Jean-Pierre Jeunet (5), France (5), French (2)
('The Silence of the Lambs', 1991, 118, 19000000.00, 272742922.00, 6, 1, 1), -- Jonathan Demme (6), USA (1), English (1)
('Whiplash', 2014, 106, 3300000.00, 48984954.00, 7, 1, 1),             -- Damien Chazelle (7), USA (1), English (1)
('Oldboy', 2003, 120, 3000000.00, 15000000.00, 8, 6, 4),               -- Park Chan-wook (8), South Korea (6), Korean (4)
('Life of Pi', 2012, 127, 120000000.00, 609016177.00, 9, 1, 1),        -- Ang Lee (9), USA (1), English (1)
('The Lord of the Rings: The Fellowship...', 2001, 178, 93000000.00, 897690623.00, 10, 7, 1); -- Peter Jackson (10), New Zealand (7), English (1)

-- Movie_genres
INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, 1), -- The Martian - Sci-Fi
(1, 2), -- The Martian - Adventure
(2, 1), -- Arrival - Sci-Fi
(2, 3), -- Arrival - Drama
(3, 1), -- Gravity - Sci-Fi
(3, 4), -- Gravity - Thriller
(4, 5), -- Spirited Away - Animation
(4, 6), -- Spirited Away - Fantasy
(5, 7), -- Amelie - Romance
(5, 8), -- Amelie - Comedy
(6, 9), -- The Silence of the Lambs - Crime
(6, 4), -- The Silence of the Lambs - Thriller
(7, 3), -- Whiplash - Drama
(8, 1), -- Oldboy - Action (ID 1)
(9, 2), -- Life of Pi - Adventure
(10, 6); -- The Lord of the Rings - Fantasy

-- Actualizarea datelor
UPDATE countries
SET name = 'United States of America' WHERE country_id = 1;

-- Verificare datelor
SELECT * FROM countries WHERE country_id = 1;

-- Stergerea datelor
SET SQL_SAFE_UPDATES = 0;
DELETE FROM movies WHERE duration < 70;
SET SQL_SAFE_UPDATES = 1;

-- Interogarea datelor
SELECT 
	title, 
    year,
    duration,
    budget 
FROM movies WHERE duration BETWEEN 120 AND 150
				  AND budget > 20000000.00
			ORDER BY duration DESC;
            
SELECT 
	m.title AS Film,
    d.name AS Regizor,
    g.name AS Gen
FROM movies m
	JOIN directors d ON m.director_id = d.director_id
	JOIN movie_genres mg ON m.movie_id = mg.movie_id
	JOIN genres g ON mg.genre_id = g.genre_id
WHERE m.budget > 100000000.00
ORDER BY m.title;