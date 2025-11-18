SHOW DATABASES;
## CREARE DB 
CREATE DATABASE vremea;

## FOLOSIRE
USE vremea;

SHOW DATABASES;

CREATE TABLE temperaturi (
	id INT PRIMARY KEY AUTO_INCREMENT, grade SMALLINT
);

## SELECT all
SELECT * FROM temperaturi;

## SELECT o coloana
SELECT grade FROM temperaturi;

SELECT grade, id FROM temperaturi;

INSERT INTO temperaturi SET id = 1, grade = 6;
SELECT * FROM temperaturi;

INSERT INTO temperaturi SET id = 2, grade = 7;
SELECT * FROM temperaturi;

INSERT INTO temperaturi SET id = 5, grade = 17;
SELECT * FROM temperaturi;

INSERT INTO temperaturi SET grade = 27;
SELECT * FROM temperaturi;

INSERT INTO temperaturi SET id = 7;
SELECT * FROM temperaturi;

DROP TABLE IF EXISTS masurari;



CREATE TABLE masurari (
	id INT PRIMARY KEY AUTO_INCREMENT, grade SMALLINT NOT NULL DEFAULT 0
);

SELECT * FROM masurari;

INSERT INTO masurari SET id = 1, grade = 10; 
SELECT * FROM masurari;

INSERT INTO masurari SET id = 2; 
SELECT * FROM masurari;


DROP TABLE IF EXISTS mamaliga;

UPDATE masurari SET grade = 3 WHERE id = 2;
SELECT * FROM masurari;



