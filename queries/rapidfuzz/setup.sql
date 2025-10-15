INSTALL rapidfuzz FROM community;
LOAD rapidfuzz;

CREATE TABLE articles (
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    content VARCHAR
);

INSERT INTO articles (id, title, content) VALUES
(1, 'The Rise of DuckDB', 'DuckDB is a fast, in-process analytical database.'),
(2, 'Full-Text Search in Databases', 'FTS allows efficient searching of text data.'),
(3, 'DuckDB and Data Analytics', 'Performing data analytics with DuckDB is straightforward.');
