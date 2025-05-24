-- 1️⃣ rangers
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);


-- 2️⃣ species
CREATE TYPE conservation_status_enum AS ENUM ('Endangered', 'Vulnerable');

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY NOT NULL,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(200),
    discovery_date DATE NOT NULL,
    conservation_status conservation_status_enum NOT NULL
);


-- 3️⃣ sightings
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY NOT NULL,
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP WITHOUT TIME ZONE,
    location VARCHAR(50) NOT NULL,
    notes TEXT
);

