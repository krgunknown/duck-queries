
CREATE TABLE notes (
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priority INTEGER DEFAULT 0
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

-- Indexes for speed
CREATE INDEX idx_note_tags_note_id ON note_tags(note_id);
CREATE INDEX idx_note_tags_tag_id ON note_tags(tag_id);
CREATE INDEX idx_tags_name ON tags(name);

-- Expanded tags
INSERT INTO tags (id, name) VALUES
    (1, 'work'), (2, 'personal'), (3, 'urgent'), (4, 'business'), (5, 'tech');

-- Sample notes with more tags
INSERT INTO notes (id, title, content, priority) VALUES
    (1, 'Meeting Notes', 'Discussed project updates and deadlines.', 8),
    (2, 'Grocery List', 'Milk, bread, eggs, and cheese.', 1),
    (3, 'Project Idea', 'New app feature for task management.', 5),
    (4, 'Performance Review', 'Reviewed employee performance.', 9),
    (5, 'Tech Research', 'Latest AI advancements in business.', 7),
    (6, 'Urgent Fix', 'Critical bug in production code.', 10);

INSERT INTO note_tags (note_id, tag_id) VALUES
    (1, 1), (1, 3),          -- work, urgent
    (2, 2),                  -- personal
    (3, 1), (3, 5),          -- work, tech
    (4, 1), (4, 3), (4, 4),  -- work, urgent, business
    (5, 4), (5, 5),          -- business, tech
    (6, 1), (6, 3), (6, 5);  -- work, urgent, tech
