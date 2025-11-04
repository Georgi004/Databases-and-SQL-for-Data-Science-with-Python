CREATE DATABASE personal;
USE personal;

## CATEGORII : Atacant, Mijlocas, Fundas, Portar
DROP TABLE IF EXISTS date_personale;
CREATE TABLE date_personale (id INT PRIMARY KEY AUTO_INCREMENT,
	prenume VARCHAR(255), 
    nume VARCHAR(255), 
    varsta INT CHECK (varsta > 5), 
    pozitie VARCHAR(255) DEFAULT 'Atacant'
); 

INSERT INTO date_personale SET prenume = 'Ion', nume = 'Ionescu';
SELECT * FROM date_personale;

INSERT INTO date_personale SET prenume = 'Alex', nume = 'Alexandrescu', varsta = 18;
SELECT * FROM date_personale;

UPDATE date_personale SET varsta = 12 WHERE id = 1;
SELECT * FROM date_personale;

INSERT INTO date_personale SET prenume = 'George', nume = 'Georgescu';
SELECT * FROM date_personale;

INSERT INTO date_personale SET prenume = 'Florin', nume = 'Florinescu';
SELECT * FROM date_personale;

INSERT INTO date_personale SET prenume = 'Mihai', nume = 'Mihailescu';
SELECT * FROM date_personale;

SELECT * FROM date_personale ORDER BY varsta;
SELECT * FROM date_personale ORDER BY varsta, nume;



SELECT * FROM date_personale WHERE varsta > 15;
SELECT * FROM date_personale WHERE varsta IS NOT NULL;
SELECT * FROM date_personale WHERE varsta IS NULL;

SELECT * FROM date_personale ORDER BY nume;

