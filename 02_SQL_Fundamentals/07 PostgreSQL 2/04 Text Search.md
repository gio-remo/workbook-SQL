# SQL Fundamentals

## PostgreSQL 2

### Lesson 04 - Full-text Search and PostgresSQL Extensions

- `_` wildcard: Used to match exactly **one** character
- `%` wildcard: Used to match zero or **more** characters

Full-text search: WHERE to_tsvector(title) @@ to_tsquery('elf');

1) 

```
SELECT *
FROM film
-- Select only records that contain the word 'GOLD'
WHERE title LIKE '%GOLD%';
```

2) 

```
-- Select the title and description
SELECT title, description
FROM film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE to_tsvector(title) @@ to_tsquery('elf');
```

### Extending PostgreSQL

User-defined data types:

```
CREATE TYPE dayofweek AS ENUM (
'Monday',
'Tuesday',
'Wednesday',
'Thursday',
'Friday',
'Saturday',
'Sunday'
);
```

User-defined functions

```
CREATE FUNCTION squared(i integer) RETURNS integer AS $$
BEGIN
RETURN i * i;
END;
$$ LANGUAGE plpgsql;
SELECT squared(10);
```