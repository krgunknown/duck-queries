INSTALL vss;
LOAD vss;

CREATE TABLE notes (
  id INTEGER PRIMARY KEY,
  content VARCHAR,
  embedding FLOAT[384]
);

CREATE INDEX notes_idx ON notes USING HNSW (embedding) WITH (metric = 'cosine');
