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