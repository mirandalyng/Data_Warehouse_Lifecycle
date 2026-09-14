--   a) Use this database and find out the underlying schemas, tables and views to get an overview of its logical structure.

SHOW DATABASES; 

USE DATABASE GOOGLE_KEYWORDS_SEARCH_DATASET_DISCOVER_ALL_SEARCHES_ON_GOOGLE; 

SHOW SCHEMAS; 

SHOW TABLES IN SCHEMA DATAFEEDS; 

SHOW VIEWS IN SCHEMA INFORMATION_SCHEMA; 

--   b) Find out the columns and its data types in the table GOOGLE_KEYWORDS.

SELECT *
FROM GOOGLE_KEYWORDS_SEARCH_DATASET_DISCOVER_ALL_SEARCHES_ON_GOOGLE.DATAFEEDS.GOOGLE_KEYWORDS;
LIMIT 100;

DESCRIBE TABLE DATAFEEDS.GOOGLE_KEYWORDS;

-- We will now do some exploratory data analysis (EDA) of this dataset.
--   c) Find out number of rows in the dataset.
SELECT COUNT(*) AS NUMBER_OF_ROWS
FROM DATAFEEDS.GOOGLE_KEYWORDS;

--   d) When is the first search and when is the latest search in the dataset?
SELECT 
    MIN(DATE) AS FIRST_SEARCH,
    MAX(DATE) AS LATEST_SEARCH
FROM DATAFEEDS.GOOGLE_KEYWORDS;

-- e) Which are the 10 most popular keywords?
SELECT 
    KEYWORD,
    COUNT(*) AS SEARCH_COUNT
FROM DATAFEEDS.GOOGLE_KEYWORDS
GROUP BY KEYWORD
ORDER BY SEARCH_COUNT DESC
LIMIT 10;

-- f) How many unique keywords are there?
SELECT COUNT(DISTINCT KEYWORD) AS UNIQUE_KEYWORDS
FROM DATAFEEDS.GOOGLE_KEYWORDS;

--   g) Check what type of platforms are used and how many users per platform
SELECT 
    PLATFORM, 
    SUM(CALIBRATED_USERS) AS NUM_OF_USERS
FROM DATAFEEDS.GOOGLE_KEYWORDS 
GROUP BY PLATFORM
ORDER BY NUM_OF_USERS DESC;

--   h) Let's dive into what swedish people are searching. Go into worldbanks country codes to find out the country code for Sweden. Find the 20 most popular keywords and the number of searches of that keyword.
SELECT 
KEYWORD,
COUNT(*) AS NUMBER_OF_SEARCHES
FROM DATAFEEDS.GOOGLE_KEYWORDS
WHERE COUNTRY = 752
GROUP BY KEYWORD
ORDER BY NUMBER_OF_SEARCHES DESC 
LIMIT 20; 


--   i) Lets see how popular spotify is around the world. List the top 10 number countries and the number of searches for spotify.
SELECT DISTINCT SITE FROM DATAFEEDS.GOOGLE_KEYWORDS WHERE SITE ILIKE '%spotify%';
SELECT 
    COUNTRY, 
    COUNT(*) AS NUM_OF_SEARCHES
FROM DATAFEEDS.GOOGLE_KEYWORDS
WHERE SITE = 'spotify.com'
GROUP BY COUNTRY
ORDER BY NUM_OF_SEARCHES DESC
LIMIT 10; 

--   j) Feel free to do additional explorations of this dataset.
