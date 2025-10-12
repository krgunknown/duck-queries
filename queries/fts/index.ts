import { DuckDBInstance } from "@duckdb/node-api";
import fs from "node:fs/promises";

try {
    await fs.unlink("my_duckdb.db");
} catch (_) {}

const instance = await DuckDBInstance.create("my_duckdb.db");
const connection = await instance.connect();

await connection.run(await fs.readFile("setup.sql", "utf8"));
await connection.run("PRAGMA create_fts_index('articles', 'id', 'content');");

const results = await connection.runAndReadAll(await fs.readFile("query1.sql", "utf8"));

console.table(results.getRowObjectsJson());

connection.closeSync();
instance.closeSync();
