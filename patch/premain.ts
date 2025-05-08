import * as fs from "fs";
import logger from "./logger.js";
import startServer from "./main.js";

const token = process.env.TOKEN;

if (!token) {
  logger.error("TOKEN environment variable not set!");
  process.exit(-1);
}

// Write the token to token.env file
fs.writeFileSync("./dist/app/token.env", process.env.TOKEN, 'utf8');

startServer();
