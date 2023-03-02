/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts integer NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg FLOAT NOT NULL	
);