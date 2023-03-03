SET datestyle = dmy;

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon','02/03/2020',0,true,10.23);

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Gabumon','15/11/2018',2,true,8.0);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Pikachu','07/01/2021',1,false,15.04);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Devimon','12/05/2017',5,true,11.0);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander','08/02/2020',0,false,-11.0);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Plantmon','15/11/2021',2,true,-5.7);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Squirtle','02/04/1993',3,false,-12.13);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Angemon','12/06/2005',1,true,-45.0);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Boarmon','07/06/2005',7,true,20.4);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Blossom','13/10/1998',3,true,17.0);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Ditto','14/05/2022',4,true,22.0);

-- insert data into owners table
INSERT INTO owners(full_name, age) VALUES('Sam Smith',34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell',19);
INSERT INTO owners(full_name, age) VALUES('Bob',45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond',77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester',14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker',38);

-- insert data into species table
INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

-- UPDATE ANIMALS TABLE

-- insert specis_id values into animal table
UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon') 
WHERE name like '%mon';

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') 
WHERE name  NOT LIKE '%mon';

-- insert owners_id values into animals table

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander','Squirtle','Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon','Boarmon');