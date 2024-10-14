SELECT *
FROM layoffs;

CREATE TABLE world_layoffs.layoffs_test
LIKE world_layoffs.layoffs;

INSERT layoffs_test
SELECT * FROM world_layoffs.layoffs;

SELECT * 
FROM layoffs_test;


SELECT *, COUNT(*) AS count
FROM world_layoffs.layoffs_test
GROUP BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised
HAVING COUNT(*) > 1;

ALTER TABLE world_layoffs.layoffs_test
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

CREATE TABLE temp_ids (id INT);
INSERT INTO temp_ids (id)
SELECT MIN(id)
FROM world_layoffs.layoffs_test
GROUP BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised
HAVING COUNT(*) > 1;


DELETE FROM world_layoffs.layoffs_test
WHERE id IN (SELECT id FROM temp_ids);

SELECT * 
FROM layoffs_test
WHERE company = "Cazoo";

SELECT * 
FROM layoffs_test
WHERE company = "Beyond Meat";

ALTER TABLE world_layoffs.layoffs_test
DROP COLUMN id;

DELETE FROM world_layoffs.layoffs_test
WHERE company IS NULL OR location IS NULL OR industry IS NULL;

DELETE FROM world_layoffs.layoffs_test
WHERE company IS NULL 
  AND location IS NULL 
  AND industry IS NULL 
  AND total_laid_off IS NULL 
  AND percentage_laid_off IS NULL 
  AND `date` IS NULL 
  AND stage IS NULL 
  AND country IS NULL 
  AND funds_raised IS NULL;

-- STANDARDISER

-- CREATION TABLE LAYOFFS_TEST2
CREATE TABLE world_layoffs.layoffs_test2
LIKE world_layoffs.layoffs_test;
INSERT layoffs_test2
SELECT * FROM world_layoffs.layoffs_test;

SELECT *
FROM world_layoffs.layoffs_test2;

-- VERIFICATION COMPAGNIE
UPDATE world_layoffs.layoffs_test2
SET company = TRIM(company);

SELECT DISTINCT company, TRIM(company)
FROM layoffs_test2
ORDER BY company;

-- VERIFICATION INDUSTRIE 
SELECT DISTINCT industry
FROM world_layoffs.layoffs_test2
ORDER BY industry;	

SELECT *
FROM world_layoffs.layoffs_test2;

UPDATE world_layoffs.layoffs_test2
SET industry = 'N/A'
WHERE industry LIKE 'https:%';

SELECT *
FROM world_layoffs.layoffs_test2
WHERE company LIKE 'ebay';

-- VERIFICATION LOCATION
SELECT DISTINCT location
FROM world_layoffs.layoffs_test2
ORDER BY location;

-- VERIFICATION COUNTRY
SELECT DISTINCT country
FROM world_layoffs.layoffs_test2
ORDER BY country;

-- 
SELECT *
FROM layoffs_test2;

UPDATE world_layoffs.layoffs_test2
SET total_laid_off = NULL
WHERE total_laid_off = '';

UPDATE world_layoffs.layoffs_test2
SET percentage_laid_off = NULL
WHERE percentage_laid_off = '';

SELECT *
FROM layoffs_test2
WHERE total_laid_off IS NULL
AND PERCENTAGE_laid_off IS NULL;





