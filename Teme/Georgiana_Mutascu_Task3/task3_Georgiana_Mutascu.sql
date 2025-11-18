DROP DATABASE IF EXISTS movies_db;

CREATE DATABASE IF NOT EXISTS movies_db;
USE movies_db;

## tabelul pentru regizori
CREATE TABLE directors (
	director_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
    );
    
## tabelul pentru tari 
CREATE TABLE countries (
	country_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

## tabelul pentru limbi
CREATE TABLE languages (
	language_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

## tabelul pentru genuri
CREATE TABLE genres (
	genre_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

##definirea tabelului 'movies'
CREATE TABLE movies (
	movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    year INT,
    duration INT, 
    budget DECIMAL (15, 2),
    box_office DECIMAL (15, 2),
    ## chei straine pentru relatiile 1:N
    director_id INT,
    country_id INT,
    language_id INT,
    ## constrangerile FOREIGN KEY
    FOREIGN KEY (director_id) REFERENCES directors(director_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

## tabelul de jonctiune 'movies_genres'
CREATE TABLE movie_genres (
	movie_id INT,
    genre_id INT,
	
    PRIMARY KEY (movie_id, genre_id),
    
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)

);

## verificarea
SHOW TABLES;
DESCRIBE directors;
DESCRIBE countries;
DESCRIBE languages;
DESCRIBE genres;
DESCRIBE movies;
DESCRIBE movie_genres;