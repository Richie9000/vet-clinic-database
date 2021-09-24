 SELECT * FROM animals WHERE NAME LIKE '%mon';
 SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
 SELECT name FROM animals WHERE NEUTERED = TRUE AND escape_attempts < 3;
 SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
 SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;	
 SELECT * FROM animals WHERE NEUTERED = TRUE;
 SELECT * FROM animals WHERE name != 'Gabumon';
 SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT name, species FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT Delete1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO Delete1;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owner, animals.name AS animal FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name AS species, COUNT(*) FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS digimon FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell'
  AND species.name = 'Digimon';

SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';

SELECT full_name AS owner, MAX(count) FROM (
  SELECT full_name, COUNT(owner_id) FROM owners
  JOIN animals ON owners.id = animals.owner_id
  GROUP BY full_name
) AS animal_count
GROUP BY full_name ORDER BY max DESC LIMIT 1;

SELECT animals.name AS animal, date_of_visit FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

SELECT DISTINCT vets.name AS vet,
  COUNT(animals.name) FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

SELECT vets.name AS vet,
  COALESCE(species.name, 'No specialties') AS specialty FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name AS animal,
  vets.name AS vet,
  date_of_visit FROM animals
JOIN visits ON animals.id = visits. animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT name AS animal,
  COUNT(name) AS visits FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY name ORDER BY visits DESC LIMIT 1;

SELECT vets.name AS vet,
  animals.name AS animal,
  date_of_visit FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit LIMIT 1;

SELECT animals.name AS animal,
  date_of_birth,
  weight_kg,
  vets.name AS vet,
  vets.age AS vet_age,
  vets.date_of_graduation,
  date_of_visit FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(animals.name) visits FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id
WHERE animals.species_id != specializations.species_id;

SELECT species.name AS species,
  COUNT(species.name) FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id ORDER BY count DESC LIMIT 1;