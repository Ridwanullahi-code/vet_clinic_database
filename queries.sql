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
DELETE FROM animals WHERE date_of_birth > '01/07/2022';
SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO savepoint_1;
UPDATE animals SET weight_kg =  (weight_kg * - 1) WHERE weight_kg < 0;
COMMIT;

--  queries to perform aggregate functions

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals

SELECT name FROM animals
ORDER BY escape_attempts DESC LIMIT 1;

SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY(species);

SELECT ROUND(AVG(escape_attempts),2) AS average FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN '1990' AND '2000'
GROUP BY(species) ORDER BY average;

-- query questions: join multiple tables

SELECT A.name,A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg
FROM animals  A 
JOIN owners OW ON A.owner_id = OW.id
WHERE OW.full_name = 'Melody Pond';

SELECT A.name,A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg
FROM animals  A 
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT OW.full_name , A.name FROM animals  A 
RIGHT JOIN owners OW ON A.owner_id = OW.id;


SELECT S.name AS species, COUNT(*) AS total_animals FROM animals A
JOIN species S ON A.species_id = S.id
GROUP BY (S.name);

SELECT A.name AS animals_name , S.name AS species_name, OW.full_name AS owner_name FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners OW ON  A.owner_id = OW.id
WHERE S.name = 'Digimon' AND OW.full_name = 'Jennifer Orwell';

SELECT A.name, A.escape_attempts, OW.full_name FROM animals  A 
JOIN owners OW ON A.owner_id = OW.id
WHERE A.escape_attempts = 0 AND OW.full_name = 'Dean Winchester';

SELECT OW.full_name AS owner_name, COUNT(A.name) AS total_animals FROM animals  A 
JOIN owners OW ON A.owner_id = OW.id
GROUP BY (OW.full_name) ORDER BY total_animals DESC
LIMIT 1;