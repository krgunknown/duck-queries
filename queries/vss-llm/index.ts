import { DuckDBInstance, arrayValue } from "@duckdb/node-api";
import { pipeline } from "@huggingface/transformers";
import fs from "node:fs/promises";

// Xenova/all-MiniLM-L6-v2 (384 dimensions)
const extractor = await pipeline("feature-extraction", "Xenova/all-MiniLM-L6-v2", { dtype: "fp32" });

// Creating duckdb instance
const instance = await DuckDBInstance.create(":memory:");
const connection = await instance.connect();

// Create notes with it's embeddings
const notes = [
    { id: 1, content: "Shinkegi No Kyojin" },
    { id: 2, content: "I Love anime" },
    { id: 3, content: "You are cute <3" },
    { id: 4, content: "DuckDB is awesome" },
    { id: 5, content: "Nichijou" },
    { id: 6, content: "Kawaii" },
    { id: 7, content: "bitch lasagna" },
    { id: 8, content: "Goblin Slayer" },
];

const notesWithEmbeddings = await Promise.all(
    notes.map(async (note) => {
        const output = await extractor(note.content, { pooling: "mean", normalize: true });
        return { ...note, embedding: Array.from(output.data) };
    }),
);

// Setup
await connection.run(await fs.readFile("setup.sql", "utf8"));

for (const note of notesWithEmbeddings) {
    await connection.run("INSERT INTO notes (id, content, embedding) VALUES ($id, $content, $embedding);", {
        id: note.id,
        content: note.content,
        embedding: arrayValue(note.embedding),
    });
}

// Query
const queryText = "Anime";
const queryOutput = await extractor(queryText, { pooling: "mean", normalize: true });
const queryEmbedding = Array.from(queryOutput.data);

const results = await connection.runAndReadAll(await fs.readFile("query1.sql", "utf8"), {
    embedding: arrayValue(queryEmbedding),
});

console.log(`Searching for "${queryText}"`);
console.table(results.getRowObjectsJson());
