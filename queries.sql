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


-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY (visits.visit_date) DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name ,COUNT(animals.name) AS total FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT VT.name AS vet_name, S.name AS species_name FROM vets VT
LEFT JOIN specializations SP ON VT.id = SP.vets_id
LEFT JOIN species S ON SP.species_id = S.id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name FROM animals A
JOIN visits V ON A.id = V.animals_id
JOIN vets VT ON V.vets_id = VT.id
WHERE V.visit_date BETWEEN  '01/04/2020' AND '30/08/2020'
GROUP BY (A.name);

-- What animal has the most visits to vets?
SELECT A.name, COUNT(*) as total_visits FROM animals A
JOIN visits V ON A.id = V.animals_id
GROUP BY (A.name) ORDER BY (total_visits) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name FROM animals A
JOIN visits V ON A.id = V.animals_id
JOIN vets VT ON V.vets_id = VT.id
WHERE VT.name = 'Maisy Smith'
ORDER BY (V.visit_date) LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.name, A.date_of_birth, A.escape_attempts,
A.neutered, A.weight_kg, VT.name, VT.age,
VT.date_of_graduation, MAX(V.visit_date) AS recent_visit
FROM animals A
JOIN visits V ON A.id = V.animals_id
JOIN vets VT ON V.vets_id = VT.id
GROUP BY (A.name, A.date_of_birth, A.escape_attempts,
		  A.weight_kg, A.neutered,VT.name, VT.age, VT.date_of_graduation)
ORDER BY recent_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits V
WHERE V.vets_id = ( 
    SELECT id FROM vets VT JOIN specializations S
	ON VT.id != S.vets_id LIMIT 1
    );  

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT A.name FROM animals A
JOIN visits V ON V.animal_id = A.id
GROUP BY A.name
ORDER BY COUNT(*) DESC LIMIT 1;