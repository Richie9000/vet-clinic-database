/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 12.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11),
  ('Plantmon', '2022-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7, true, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17);


INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon');

INSERT INTO species (name)
VALUES ('Digimon');

UPDATE animals
SET species_id = species.id FROM species
WHERE animals.name LIKE '%mon' AND species.name = 'Digimon';

UPDATE animals
SET species_id = species.id FROM species
WHERE species_id IS NULL AND species.name = 'Pokemon';

UPDATE animals
SET owner_id = owners.id FROM owners
WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE animals
SET owner_id = owners.id FROM owners
WHERE animals.name = 'Gabumon' AND owners.full_name = 'Jennifer Orwell'
  OR animals.name = 'Pikachu' AND owners.full_name = 'Jennifer Orwell';

UPDATE animals
SET owner_id = owners.id FROM owners
WHERE animals.name = 'Devimon' AND owners.full_name = 'Bob'
  OR animals.name = 'Plantmon' AND owners.full_name = 'Bob';

UPDATE animals
SET owner_id = owners.id FROM owners
WHERE animals.name = 'Charmander' AND owners.full_name = 'Melody Pond'
  OR animals.name = 'Squirtle' AND owners.full_name = 'Melody Pond'
  OR animals.name = 'Blossom' AND owners.full_name = 'Melody Pond';

UPDATE animals
SET owner_id = owners.id FROM owners
WHERE animals.name = 'Angemon' AND owners.full_name = 'Dean Winchester'
  OR animals.name = 'Boarmon' AND owners.full_name = 'Dean Winchester';