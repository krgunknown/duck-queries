import { DuckDBInstance } from "@duckdb/node-api";
import fs from "fs/promises";

try {
    await fs.unlink("my_duckdb.db");
} catch (_) {}

const instance = await DuckDBInstance.create("my_duckdb.db");
const connection = await instance.connect();

await connection.run(await fs.readFile("setup.sql", "utf8"));

const meetingReaderReader = await connection.runAndReadAll(await fs.readFile("query1.sql", "utf8"));
const workTagReaderReader = await connection.runAndReadAll(await fs.readFile("query2.sql", "utf8"));

const requiredTags = ["work", "urgent"];
const tagNames = requiredTags.map((t) => `'${t}'`).join(", ");
const tagCount = requiredTags.length;
const workAndUrgentTagReaderReader = await connection.runAndReadAll(await fs.readFile("query3.sql", "utf8"), {
    tagNames,
    tagCount,
});

console.log("Meeting Notes with tags:");
console.table(meetingReaderReader.getRowObjectsJson());
console.log("Notes with the work tag:");
console.table(workTagReaderReader.getRowObjectsJson());
console.log("Notes with work AND urgent tags (prioritized):");
console.table(workAndUrgentTagReaderReader.getRowObjectsJson());

connection.closeSync();
instance.closeSync();
