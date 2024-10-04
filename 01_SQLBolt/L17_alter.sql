-- L17: https://sqlbolt.com/lesson/altering_tables

-- Add new column
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint DEFAULT default_value;

-- Remove column
ALTER TABLE mytable
DROP column_to_be_deleted;

-- Altering table name
ALTER TABLE mytable
RENAME TO new_table_name;

-- Exercises

-- 17.1 Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in
ALTER TABLE movies
ADD Aspect_ratio FLOAT;

-- 17.2 Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English
ALTER TABLE movies
ADD Language VARCHAR(20) DEFAULT "English";