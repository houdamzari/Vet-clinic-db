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
