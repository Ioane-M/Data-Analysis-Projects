-- SQL Project - Layoffs 2022 Dataset (Kaggle)
-- Full process: Data Cleaning → EDA
-- Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022


-- STEP 1: CREATE STAGING TABLE
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

INSERT INTO world_layoffs.layoffs_staging 
SELECT * FROM world_layoffs.layoffs;


-- STEP 2: REMOVE DUPLICATES

-- Identify duplicate rows using ROW_NUMBER()
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
		) AS row_num
	FROM world_layoffs.layoffs_staging
) duplicates
WHERE row_num > 1;

-- Create a second staging table to store data with row numbers
CREATE TABLE `world_layoffs`.`layoffs_staging2` (
	`company` TEXT,
	`location` TEXT,
	`industry` TEXT,
	`total_laid_off` INT,
	`percentage_laid_off` TEXT,
	`date` TEXT,
	`stage` TEXT,
	`country` TEXT,
	`funds_raised_millions` INT,
	row_num INT
);

-- Populate staging2 with row numbers
INSERT INTO `world_layoffs`.`layoffs_staging2`
(`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`, `row_num`)
SELECT `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`,
	ROW_NUMBER() OVER (
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM world_layoffs.layoffs_staging;

-- Delete duplicate rows where row_num >= 2
DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;


-- STEP 3: STANDARDIZE DATA

-- View unique industry values
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

-- Set empty industry values to NULL
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Fill in NULL industry values based on other rows of the same company
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Standardize similar industry values
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- Fix country name inconsistencies (e.g., "United States.")
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- Convert date column to proper DATE type
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- STEP 4: REMOVE NON-USABLE ROWS

-- Remove rows with both total_laid_off and percentage_laid_off as NULL
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Drop helper row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- STEP 5: EXPLORATORY DATA ANALYSIS (EDA)

-- Basic Overview
SELECT * FROM world_layoffs.layoffs_staging2;

-- Maximum layoffs in a single entry
SELECT MAX(total_laid_off) FROM world_layoffs.layoffs_staging2;

-- Maximum and minimum percentage layoffs
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Companies that laid off 100% of staff
SELECT * FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1;

-- These are mostly failed startups; order by raised funds
SELECT * FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- Grouped Aggregations

-- Top 5 companies with the largest single layoff event
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY total_laid_off DESC
LIMIT 5;

-- Companies with most total layoffs
SELECT company, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY total DESC
LIMIT 10;

-- Layoffs by location
SELECT location, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY total DESC
LIMIT 10;

-- Layoffs by country
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Layoffs by year
SELECT YEAR(date) AS year, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY year
ORDER BY year;

-- Layoffs by industry
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Layoffs by funding stage
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


-- Top 3 Companies by Layoffs Each Year
WITH Company_Year AS (
	SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
	FROM layoffs_staging2
	GROUP BY company, YEAR(date)
),
Company_Year_Rank AS (
	SELECT company, years, total_laid_off,
		DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
	FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years, total_laid_off DESC;


-- Rolling Total of Layoffs Per Month
WITH DATE_CTE AS (
	SELECT DATE_FORMAT(date, '%Y-%m') AS dates, SUM(total_laid_off) AS total_laid_off
	FROM layoffs_staging2
	GROUP BY dates
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates;
