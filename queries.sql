/*Queries that provide answers to the questions from all projects.*/



    -- Find all animals whose name ends in "mon":
    SELECT * FROM animals WHERE name LIKE '%mon';

    -- List the name of all animals born between 2016 and 2019:
    SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

  --  List the name of all animals that are neutered and have less than 3 escape attempts:
   SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

    -- List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');


    -- List name and escape attempts of animals that weigh more than 10.5kg:
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

    -- Find all animals that are neutered:
    SELECT * FROM animals WHERE neutered = TRUE;

        -- Find all animals not named Gabumon:
SELECT * FROM animals WHERE name <> 'Gabumon';


-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg):
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Begin the transaction
BEGIN;

-- Update the species column of all animals to 'unspecified'
UPDATE animals SET species = 'unspecified';

-- Verify that the change was made
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species column went back to its state before the transaction
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Update the species column to 'digimon' for all animals whose name ends in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the species column to 'pokemon' for all animals whose species is not set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction
COMMIT;

-- Verify that the changes were made and persist after commit
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Update the species column of all animals to 'unspecified'
UPDATE animals SET species = 'unspecified';

-- Verify that the change was made
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species column went back to its state before the transaction
SELECT * FROM animals;


-- Begin the transaction
BEGIN;

-- Update the species column to 'digimon' for all animals whose name ends in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the species column to 'pokemon' for all animals whose species is not set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Commit the transaction
COMMIT;

-- Verify that the changes were made and persist after commit
SELECT * FROM animals;

-- SQL code to delete all records in the animals table inside a transaction and then roll back the transaction

BEGIN;

DELETE FROM animals;

ROLLBACK;

SELECT * FROM animals;

    -- How many animals are there?
SELECT COUNT(*) FROM animals;

    -- How many animals have never tried to escape?
   SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

    -- What is the average weight of animals?
    SELECT AVG(weight_kg) FROM animals;

        -- Who escapes the most, neutered or not neutered animals?
        SELECT neutered, SUM(escape_attempts) as total_escapes 
FROM animals 
GROUP BY neutered 
ORDER BY total_escapes DESC 
LIMIT 1;

    -- What is the minimum and maximum weight of each type of animal?
    SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight 
FROM animals 
GROUP BY species;


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as avg_escape_attempts 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

    -- What animals belong to Melody Pond?
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

    -- List of all animals that are pokemon (their type is Pokemon).
    SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

    -- List all owners and their animals, remember to include those that don't own any animal.

    SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

    -- How many animals are there per species?
SELECT species.name, COUNT(*) AS count
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

    -- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';


    -- List all animals owned by Dean Winchester that haven't tried to escape.

    SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.tried_to_escape = 0;



    -- Who owns the most animals?
    SELECT owners.full_name, COUNT(*) AS count
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY count DESC
LIMIT 1;

-- List all vets and their specialties, including vets with no specialties.
SELECT * FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON species.id = specializations.species_id;


-- How many different animals did Stephanie Mendez see?
SELECT a.name AS "Animal", v.name AS "Vet", visits.visit_date AS "Visit Date"
FROM visits
JOIN animals a ON visits.animal_id = a.id
JOIN vets v ON visits.vet_id = v.id
WHERE visits.visit_date = (SELECT MAX(visit_date) FROM visits)

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id AND vet.name = 'Stephanie Mendez'
WHERE v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?
SELECT animals.name AS "Animal", COUNT(*) AS "Visits"
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY COUNT(*) DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?

SELECT vets.name AS "Vet", animals.name AS "Animal", visits.visit_date
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  vets.id AS "Vet-id", vets.name AS "Vet", date_of_graduation,

  visits.visit_date,

  animals.id AS "Animal-id", animals.name AS "Animal", date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  JOIN animals
    ON visits.animal_id = animals.id
  ORDER BY visit_date DESC LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?


SELECT vets.name
  FROM vets
  JOIN visits
    ON vets.id = visits.vet_id
  LEFT JOIN specializations
    ON vets.id = specializations.vet_id
  WHERE specializations.vet_id IS NULL
  GROUP BY vets.name;







-- specialty should Maisy Smith consider getting
SELECT species.name AS "specie's name",
COUNT(*) AS "nbr of visits" FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;