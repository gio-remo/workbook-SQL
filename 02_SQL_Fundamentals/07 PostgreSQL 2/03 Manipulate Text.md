# SQL Fundamentals

## PostgreSQL 2

### Lesson 03 - Parsing and Manipulating Text

String concatenation operator: || or CONCAT(first_name,' ', last_name)

- UPPER(text) = uppercase
- LOWER(text) = lowercase

REPLACE(column, old text, new text)

REVERSE() = reverse string

1) 

```
SELECT first_name || ' ' || last_name || ' <' || email || '>' AS full_email 
FROM customer

SELECT CONCAT(first_name, ' ', last_name, ' <', email, '>') AS full_email 
FROM customer
```

2) 

```
SELECT 
  -- Replace whitespace in the film title with an underscore
  REPLACE(title, ' ', '_') AS title
FROM film;
```

### Parsing string and character data

CHAR_LENGTH(colname) or LENGTH(colname) = string length

POSITION('@' IN email) = position in the string

LEFT(description, 50) = first 50 chars of the string

3) 

```
SELECT 
  -- Select the title and description columns
  title,
  description,
  -- Determine the length of the description column
  LENGTH(description) AS desc_len
FROM film;
```

4) 

```
SELECT 
  -- Select the first 50 characters of description
  LEFT(description, 50) AS short_desc
FROM 
  film AS f; 
```

5) Extract only the street address without the street number from the address column

```
SELECT 
  -- Select only the street name from the address table
  SUBSTRING(address FROM POSITION(' ' IN address)+1 FOR LENGTH(address))
FROM 
  address;
```

6) 

```
SELECT
  -- Extract the characters to the left of the '@'
  LEFT(email, POSITION('@' IN email)-1) AS username,
  -- Extract the characters to the right of the '@'
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR LENGTH(email)) AS domain
FROM customer;
```

### Truncating and padding string data

Removing whitespace from strings: **TRIM**([leading | trailing | both] [characters] from string)

Padding strings with character data: SELECT **LPAD**('padded', 10, '#');