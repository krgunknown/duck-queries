CREATE TABLE notes (
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    content TEXT
);

CREATE TABLE links (
    id INTEGER PRIMARY KEY,
    from_note INTEGER REFERENCES notes(id),
    to_note INTEGER REFERENCES notes(id)
);

CREATE TABLE tags (
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE note_tags (
    note_id INTEGER NOT NULL REFERENCES notes(id),
    tag_id INTEGER NOT NULL REFERENCES tags(id),
    PRIMARY KEY (note_id, tag_id)
);

INSERT INTO tags (id, name) VALUES
    (1, 'work'),
    (2, 'personal'),
    (3, 'urgent');

INSERT INTO notes (id, title, content) VALUES
    (1, 'Meeting Notes', 'Discussed project updates and deadlines.'),
    (2, 'Grocery List', 'Milk, bread, eggs, and cheese.'),
    (3, 'Project Idea', 'New app feature for task management.'),
    (4, 'Performance Review', 'Reviewed employee performance.');

INSERT INTO note_tags (note_id, tag_id) VALUES
    (1, 1),  -- Meeting Notes: work
    (1, 3),  -- Meeting Notes: urgent
    (2, 2),  -- Grocery List: personal
    (3, 1),  -- Project Idea: work
    (4, 1),  -- Performance Review: work
    (4, 3);  -- Performance Review: urgent
