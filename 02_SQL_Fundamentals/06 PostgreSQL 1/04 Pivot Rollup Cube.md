# SQL Fundamentals

## PostgreSQL 1

### Lesson 04 - Beyond window functions

### Pivoting

Transforming tables using **CROSSTAB**.

1) 

```
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
  SELECT
    Gender, Year, Country
  FROM Summer_Medals
  WHERE
    Year IN (2008, 2012)
    AND Medal = 'Gold'
    AND Event = 'Pole Vault'
  ORDER By Gender ASC, Year ASC;
$$) AS ct (Gender VARCHAR,
           "2008" VARCHAR,
           "2012" VARCHAR)

ORDER BY Gender ASC;
```

2) 

```
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
  WITH Country_Awards AS (
    SELECT
      Country,
      Year,
      COUNT(*) AS Awards
    FROM Summer_Medals
    WHERE
      Country IN ('FRA', 'GBR', 'GER')
      AND Year IN (2004, 2008, 2012)
      AND Medal = 'Gold'
    GROUP BY Country, Year)

  SELECT
    Country,
    Year,
    RANK() OVER
      (PARTITION BY Year
       ORDER BY Awards DESC) :: INTEGER AS rank
  FROM Country_Awards
  ORDER BY Country ASC, Year ASC;
$$) AS ct (country VARCHAR,
           "2004" INTEGER,
           "2008" INTEGER,
           "2012" INTEGER)

Order by Country ASC;
```

### ROLLUP

To return aggregated results at multiple levels of details, you use the ROLLUP with the GROUP BY clause.

ROLLUP is hierarchical, de-aggregating from the leftmost provided column to the right-most
- ROLLUP(Country, Medal) includes Country -level totals
- ROLLUP(Medal, Country) includes Medal -level totals

### CUBE

CUBE is a non-hierarchical ROLLUP
- It generates all possible group-level aggregations
- CUBE(Country, Medal) counts Country -level, Medal -level, and grand totals

**ROLLUP vs CUBE**

Use ROLLUP when you have hierarchical data (e.g., date parts) and don't want all possible group-level aggregations

Use CUBE when you want all possible group-level aggregations

3) You want to look at three Scandinavian countries' earned gold medals per country and gender in the year 2004. You're also interested in Country-level subtotals to get the total medals earned for each country, but Gender-level subtotals don't make much sense in this case, so disregard them.

```
-- Count the gold medals per country and gender
SELECT
  Country,
  Gender,
  COUNT(*) AS Gold_Awards
FROM Summer_Medals
WHERE
  Year = 2004
  AND Medal = 'Gold'
  AND Country IN ('DEN', 'NOR', 'SWE')
-- Generate Country-level subtotals
GROUP BY Country, ROLLUP(Gender)
ORDER BY Country ASC, Gender ASC;
```

4) 

```
-- Count the medals per gender and medal type
SELECT
  gender,
  medal,
  COUNT(*) AS Awards
FROM Summer_Medals
WHERE
  Year = 2012
  AND Country = 'RUS'
-- Get all possible group-level subtotals
GROUP BY CUBE(gender, Medal)
ORDER BY Gender ASC, Medal ASC;
```

### COALESCE

COALESCE() takes a list of values and returns the first non- null value, going from left to right

5) Turn the nulls in the Country column to All countries, and the nulls in the Gender column to All genders

```
SELECT
  -- Replace the nulls in the columns with meaningful text
  COALESCE(Country, 'All countries') AS Country,
  COALESCE(Gender, 'All genders') AS Gender,
  COUNT(*) AS Awards
FROM Summer_Medals
WHERE
  Year = 2004
  AND Medal = 'Gold'
  AND Country IN ('DEN', 'NOR', 'SWE')
GROUP BY ROLLUP(Country, Gender)
ORDER BY Country ASC, Gender ASC;
```

### STRING_AGG

STRING_AGG(column, separator) takes all the values of a column and concatenates them, with separator in between each value

6) Rank countries by the medals they've been awarded

```
WITH Country_Medals AS (
  SELECT
    Country,
    COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE Year = 2000
    AND Medal = 'Gold'
  GROUP BY Country),

  Country_Ranks AS (
  SELECT
    Country,
    RANK() OVER (ORDER BY Medals DESC) AS Rank
  FROM Country_Medals
  ORDER BY Rank ASC)

-- Compress the countries column
SELECT STRING_AGG(Country, ', ')
FROM Country_Ranks
-- Select only the top three ranks
WHERE Rank <= 3;
```