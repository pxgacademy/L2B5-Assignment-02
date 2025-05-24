-- 1️⃣ rangers
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);


-- 2️⃣ species
CREATE TYPE conservation_status_enum AS ENUM ('Endangered', 'Vulnerable', 'Historic');

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

-- insert values to RANGERS
INSERT INTO rangers(name, region)
VALUES 
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- insert values to SPECIES
INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status)
VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda',  'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- insert values to SIGHTINGS
INSERT INTO sightings(species_id, ranger_id, location, sighting_time, notes)
VALUES 
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



/*
1️⃣ Register a new ranger with provided data with
name = 'Derek Fox' 
region = 'Coastal Plains'
*/
INSERT INTO rangers(name, region) VALUES ('Derek Fox', 'Coastal Plains');


-- 2️⃣ Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_sighted FROM sightings;


-- 3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE "location" ILIKE '%Pass%';


-- 4️⃣ List each ranger's name and their total number of sightings.
SELECT rangers.name, COUNT(sightings.sighting_id)
FROM rangers LEFT JOIN sightings
ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name ORDER BY rangers.name;


-- 5️⃣ List species that have never been sighted.
SELECT species.common_name FROM species LEFT JOIN sightings
ON species.species_id = sightings.species_id WHERE sightings.sighting_id IS NULL;


-- 6️⃣ Show the most recent 2 sightings.
SELECT  species.common_name, sightings.sighting_time, rangers.name
FROM sightings JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC LIMIT 2;


-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species SET conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';







SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

