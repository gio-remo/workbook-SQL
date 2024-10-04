-- L16: https://sqlbolt.com/lesson/creating_tables

CREATE TABLE IF NOT EXISTS mytable (
    column DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value,
    …
);

-- Data types:
-- BOOLEAN
-- INTEGER
-- FLOAT
-- VARCHAR(num_chars)
-- DATE

-- Table constraints:
-- PRIMARY KEY
-- UNIQUE
-- NOT NULL
-- FOREIGN KEY

-- Exercise

-- 16.1
CREATE TABLE IF NOT EXISTS Database (
    Name VARCHAR(30),
    Version FLOAT,
    Download_count INTEGER
);