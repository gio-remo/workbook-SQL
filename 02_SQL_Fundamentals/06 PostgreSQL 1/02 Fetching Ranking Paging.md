# SQL Fundamentals

## PostgreSQL 1

### Lesson 02 - Fetching, ranking, and paging

### Fetching

**Relative**
- LAG(column, n) returns column 's value at the row n rows *before* the current row
- LEAD(column, n) returns column 's value at the row n rows af*ter the current row

**Absolute**
- FIRST_VALUE(column) returns the *first* value in the table or partition
- LAST_VALUE(column) returns the *last* value in the table or partition

1) 

```
WITH Discus_Medalists AS (
  SELECT DISTINCT
    Year,
    Athlete
  FROM Summer_Medals
  WHERE Medal = 'Gold'
    AND Event = 'Discus Throw'
    AND Gender = 'Women'
    AND Year >= 2000)

SELECT
  -- For each year, fetch the current and future medalists
  Year,
  Athlete,
  LEAD(Athlete, 3) OVER (ORDER BY Year ASC) AS Future_Champion
FROM Discus_Medalists
ORDER BY Year ASC;
```

It's often useful to get the first or last value in a dataset to compare all other values to it. With absolute fetching functions like FIRST_VALUE, you can fetch a value at an absolute position in the table, like its beginning or end.

2) Return all athletes and the first athlete ordered by alphabetical order.

```
WITH All_Male_Medalists AS (
  SELECT DISTINCT
    Athlete
  FROM Summer_Medals
  WHERE Medal = 'Gold'
    AND Gender = 'Men')

SELECT
  -- Fetch all athletes and the first athlete alphabetically
  Athlete,
  FIRST_VALUE(Athlete) OVER (
    ORDER BY Athlete ASC
  ) AS First_Athlete
FROM All_Male_Medalists;
```

3) Fetch the last city in which the Olympic games were held.

```
WITH Hosts AS (
  SELECT DISTINCT Year, City
    FROM Summer_Medals)

SELECT
  Year,
  City,
  -- Get the last city in which the Olympic games were held
  LAST_VALUE(City) OVER (
   ORDER BY Year ASC
   RANGE BETWEEN
     UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING
  ) AS Last_City
FROM Hosts
ORDER BY Year ASC;
```

### Ranking

- **ROW_NUMBER()** always assigns unique numbers, even if two rows' values are the same
- **RANK()** assigns the same number to rows with identical values, skipping over the next numbers in such cases
- **DENSE_RANK()** also assigns the same number to rows with identical values, but doesn't skip over the next numbers

4) Rank each athlete by the number of medals they've earned, with identical numbers in case of identical values

```
WITH Athlete_Medals AS (
  SELECT
    Athlete,
    COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete)

SELECT
  Athlete,
  Medals,
  -- Rank athletes by the medals they've won
  RANK() OVER (ORDER BY Medals DESC) AS Rank_N
FROM Athlete_Medals
ORDER BY Medals DESC;
```

5) 

```
WITH Athlete_Medals AS (
  SELECT
    Country, Athlete, COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE
    Country IN ('JPN', 'KOR')
    AND Year >= 2000
  GROUP BY Country, Athlete
  HAVING COUNT(*) > 1)

SELECT
  Country,
  -- Rank athletes in each country by the medals they've won
  Athlete,
  DENSE_RANK() OVER (PARTITION BY Country
                ORDER BY Medals DESC) AS Rank_N
FROM Athlete_Medals
ORDER BY Country ASC, RANK_N ASC;
```

### Paging

Paging: Splitting data into (approximately) equal chunks

Uses
- Many APIs return data in "pages" to reduce data being sent
- Separating data into quartiles or thirds (top middle 33%, and bottom thirds) to judge performance

**NTILE(n)** splits the data into n approximately equal pages

6) Split the distinct events into exactly 111 groups, ordered by event in alphabetical order.

```
WITH Events AS (
  SELECT DISTINCT Event
  FROM Summer_Medals)
  
SELECT
  --- Split up the distinct events into 111 unique groups
  event,
  NTILE(111) OVER (ORDER BY event ASC) AS Page
FROM Events
ORDER BY Event ASC;
```

7) 

```
WITH Athlete_Medals AS (
  SELECT Athlete, COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete
  HAVING COUNT(*) > 1),
  
  Thirds AS (
  SELECT
    Athlete,
    Medals,
    NTILE(3) OVER (ORDER BY Medals DESC) AS Third
  FROM Athlete_Medals)
  
SELECT
  -- Get the average medals earned in each third
  Third,
  AVG(Medals) AS Avg_Medals
FROM Thirds
GROUP BY Third
ORDER BY Third ASC;
```