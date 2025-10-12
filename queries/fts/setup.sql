-- 1. Install and Load the FTS Extension (if not already autoloaded)
INSTALL 'fts';
LOAD 'fts';

-- 2. Create a table with text content
CREATE TABLE articles (
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    content VARCHAR
);

-- 3. Insert some sample data
INSERT INTO articles (id, title, content) VALUES
(1, 'The Rise of DuckDB', 'DuckDB is a fast, in-process analytical database.'),
(2, 'Full-Text Search in Databases', 'FTS allows efficient searching of text data.'),
(3, 'DuckDB and Data Analytics', 'Performing data analytics with DuckDB is straightforward.');
