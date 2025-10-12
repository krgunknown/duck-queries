import { spawn, execSync } from "node:child_process";
import path from "node:path";
import fs from "node:fs";

let name = process.argv[2];
if (!name) {
    console.error("❌ Missing query name. Usage: bun index.ts <name> \nExample: bun index.ts fts");
    process.exit(1);
}

const queryPath = path.join("queries", name);

const dir = path.resolve(queryPath);
if (!fs.existsSync(dir)) {
    console.error(`❌ Query '${queryPath}' not found in ./${queryPath}`);
    process.exit(1);
}

const entryFile = path.join(dir, "index.ts");
if (!fs.existsSync(entryFile)) {
    console.error(`❌ No index.ts found in ./${queryPath}`);
    process.exit(1);
}

const child = spawn("bun", [entryFile], {
    cwd: dir,
    stdio: "inherit",
    shell: true,
});
child.on("exit", (code) => process.exit(code));
