-- MISSION 1
SELECT *
FROM observations
LIMIT 10;

-- MISSION 2
SELECT DISTINCT region_id
FROM observations;

-- MISSION 3
SELECT COUNT(DISTINCT species_id) AS total_species
FROM observations;

-- MISSION 4
SELECT COUNT(*)
FROM observations
WHERE region_id = 2;

-- MISSION 5
-- Observaciones en una fecha concreta
SELECT *
FROM observations
WHERE observation_date = '1998-08-08';

-- MISSION 6
-- Región con más observaciones (top 1)
SELECT region_id, COUNT(*) AS total_observations
FROM observations
GROUP BY region_id
ORDER BY total_observations DESC
LIMIT 1;

-- MISSION 7
-- Especies con menos de 5 observaciones (de mayor a menor)
SELECT species_id, COUNT(*) AS observation_count
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY observation_count DESC;

-- MISSION 8
-- Especies con menos de 5 observaciones (de menor a mayor)
SELECT species_id, COUNT(*) AS total_observations
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY total_observations ASC;

-- MISSION 9
-- Observadores con su total de observaciones
SELECT observer, COUNT(*) AS total
FROM observations
GROUP BY observer
ORDER BY total DESC;

-- MISSION 10
-- Observaciones unidas con regiones
SELECT o.id,
       r.name AS region_name,
       o.observation_date
FROM observations AS o
JOIN regions AS r
  ON o.region_id = r.id;


-- MISSION 11 

SELECT DISTINCT s.scientific_name
FROM observations o
JOIN species s ON s.id = o.species_id;


-- MISSION 12

WITH counts AS ( 
    SELECT s.scientific_name,
           r.name AS region_name,
           COUNT(*) AS observation_count
    FROM observations o
    JOIN species s ON s.id = o.species_id
    JOIN regions r ON r.id = o.region_id
    GROUP BY s.scientific_name, r.name
)
SELECT scientific_name, region_name, observation_count
FROM counts
ORDER BY region_name, scientific_name;




