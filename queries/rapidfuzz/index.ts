import { DuckDBInstance } from "@duckdb/node-api";
import fs from "node:fs/promises";

try {
    await fs.unlink("my_duckdb.db");
} catch (_) {}

const instance = await DuckDBInstance.create("my_duckdb.db");
const connection = await instance.connect();

await connection.run(await fs.readFile("setup.sql", "utf8"));

const results1 = await connection.runAndReadAll(await fs.readFile("query1.sql", "utf8"));
const results2 = await connection.runAndReadAll(await fs.readFile("query2.sql", "utf8"));

console.log("Results from query1:");
console.table(results1.getRowObjectsJson());
console.log("Results from query2:");
console.table(results2.getRowObjectsJson());

connection.closeSync();
instance.closeSync();
