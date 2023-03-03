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

-- queries to perform transaction

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon'WHERE species is null;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
SAVEPOINT SAVEp1;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SAVEp2; 
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEp2;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

--  queries to perform aggregate functions

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals

SELECT neutered, MAX(escape_attempts) FROM animals
WHERE escape_attempts != 0
GROUP BY(neutered)

SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY(species);

SELECT ROUND(AVG(escape_attempts),2) AS average FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN '1990' AND '2000'
GROUP BY(species) ORDER BY average;