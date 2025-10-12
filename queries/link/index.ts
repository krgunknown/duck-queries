import { DuckDBInstance } from "@duckdb/node-api";
import fs from "fs/promises";

try {
    await fs.unlink("my_duckdb.db");
} catch (_) {}

const instance = await DuckDBInstance.create("my_duckdb.db");
const connection = await instance.connect();

await connection.run(await fs.readFile("setup.sql", "utf8"));

const results = await connection.runAndReadAll(await fs.readFile("query1.sql", "utf8"));

console.table(results.getRowObjectsJson());

connection.closeSync();
instance.closeSync();
