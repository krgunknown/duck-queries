
CREATE TABLE notes (
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    content TEXT
);

CREATE TABLE links (
    id INTEGER PRIMARY KEY,
    from_note INTEGER REFERENCES notes(id),
    to_note INTEGER REFERENCES notes(id),
--     this is necessary if a direct REFERENCES doesnt work.
--     FOREIGN KEY (from_note) REFERENCES notes(id),
--     FOREIGN KEY (to_note) REFERENCES notes(id)
);

INSERT INTO notes (id, title, content) VALUES
(1, 'Getting Started', 'Welcome to your personal knowledge base. This note links to key topics.'),
(2, 'DuckDB', 'An in-process SQL OLAP database management system. Useful for querying local data like notes.'),
(3, 'JavaScript', 'A versatile programming language for web development and more. Often used with Node.js APIs.');

INSERT INTO links (id, from_note, to_note) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 3);

-- UUID

-- CREATE TABLE notes (
--     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     title VARCHAR,
--     content TEXT
-- );

-- CREATE TABLE links (
--     id UUID PRIMARY KEY DEFAULT uuid(),
--     from_note UUID REFERENCES notes(id),
--     to_note UUID REFERENCES notes(id)
-- );

-- INSERT INTO notes (title, content) VALUES
-- ('Getting Started', 'Welcome to your personal knowledge base. This note links to key topics.'),
-- ('DuckDB', 'An in-process SQL OLAP database management system. Useful for querying local data like notes.'),
-- ('JavaScript', 'A versatile programming language for web development and more. Often used with Node.js APIs.');

-- INSERT INTO links (from_note, to_note) VALUES
-- ((SELECT id FROM notes WHERE title = 'Getting Started'), (SELECT id FROM notes WHERE title = 'DuckDB')),
-- ((SELECT id FROM notes WHERE title = 'Getting Started'), (SELECT id FROM notes WHERE title = 'JavaScript')),
-- ((SELECT id FROM notes WHERE title = 'DuckDB'), (SELECT id FROM notes WHERE title = 'JavaScript'));
