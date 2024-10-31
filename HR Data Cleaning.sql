CREATE DATABASE projects;
USE Projects;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ď»żid emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE 
   WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
   WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
   ELSE NULL
END;   

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;


SELECT birthdate FROM hr;

UPDATE hr
SET hire_date = CASE 
   WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
   WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
   ELSE NULL
END;   

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SET @@global.sql_mode = '';

UPDATE hr 
SET termdate = CASE
    WHEN termdate = '' THEN NULL
    ELSE termdate
END;

UPDATE hr 
SET termdate = NULL 
WHERE termdate = '';

SELECT *
FROM hr
WHERE termdate = '';


UPDATE hr 
SET termdate = '0000-00-00' 
WHERE termdate = '' OR termdate IS NULL;

UPDATE hr 
SET termdate = '0000-00-00' 
WHERE termdate IS NULL;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- Empty value actualization to '0000-00-00' - Setting sql_mode to support "zero dates":
SELECT @@SESSION.sql_mode;
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';

-- Empty value actualization to '0000-00-00':
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = '' OR termdate IS NULL;

SELECT termdate FROM hr;

SELECT termdate FROM hr WHERE termdate = '0000-00-00';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

SELECT 
  min(age) AS youngest,
  max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

-- SELECT termdate FROM hr;

-- SELECT birthdate FROM hr;
