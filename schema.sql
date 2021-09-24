/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

ALTER TABLE animals
DROP COLUMN IF EXISTS species;

ALTER TABLE animals
ADD COLUMN IF NOT EXISTS species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN IF NOT EXISTS owner_id INT REFERENCES owners(id);

CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	date_of_graduation DATE
);