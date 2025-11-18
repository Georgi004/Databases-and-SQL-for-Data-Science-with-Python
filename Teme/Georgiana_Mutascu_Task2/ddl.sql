-- Model logic SQL pentru baza de date "Movies"

CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE languages (
    language_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT,
    duration INT,
    budget DECIMAL(15,2),
    box_office DECIMAL(15,2),
    director_id INT,
    country_id INT,
    language_id INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

CREATE TABLE movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);
