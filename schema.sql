/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts integer NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg FLOAT NOT NULL	
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

-- create new tables
CREATE TABLE owners(
    id SERIAL NOT NULL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    age INT NOT NULL
)
-- create species table
CREATE TABLE species(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
)

-- delete species column in animals table
ALTER TABLE animals DROP COLUMN species;

-- one-to-many relationship: add new columns to animals table
ALTER TABLE animals
ADD COLUMN species_id INT CONSTRAINT animals_fk
REFERENCES species(id) ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owner_id INT CONSTRAINT fk_animals
REFERENCES owners(id) ON DELETE CASCADE;

-- create vets table
CREATE TABLE vets(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INTEGER NOT NULL,
    date_of_graduation DATE
);

-- many-many relationship: create table to connects two table together
CREATE TABLE specializations(
    species_id INT REFERENCES species(id) ON DELETE CASCADE,
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE visits(
    animals_id INT REFERENCES animals(id) ON DELETE CASCADE,
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE,
    visit_date DATE
);