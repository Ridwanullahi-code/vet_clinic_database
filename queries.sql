/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon'
ORDER BY id ASC;

SELECT name FROM animals
WHERE extract(year from date_of_birth) BETWEEN '2016' AND '2019';

SELECT name FROM animals
WHERE neutered = TRUE AND escape_attempts < 3
ORDER BY id ASC;

SELECT TO_CHAR(date_of_birth:: date,  'Mon dd, yyyy') AS birth FROM animals
WHERE name = 'Agumon' or name = 'Pikachu';

SELECT name, escape_attempts from animals
WHERE weight_kg > 10.5 ;

SELECT * FROM animals
WHERE neutered = true;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3