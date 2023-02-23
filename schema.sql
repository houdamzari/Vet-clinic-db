/* Database schema to keep the structure of entire database. */


CREATE TABLE animals (
  id INTEGER,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(10,2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE animals ADD COLUMN id INTEGER PRIMARY KEY AUTOINCREMENT;

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER,
    date_of_graduation DATE
);


-- specializations table
CREATE TABLE specializations (
    vet_id INTEGER,
    species_id INTEGER,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- visits table
CREATE TABLE visits (
    vet_id INTEGER,
    animal_id INTEGER,
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
FOREIGN KEY (animal_id) REFERENCES animals(id)
);
