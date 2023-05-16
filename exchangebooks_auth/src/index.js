import express from "express";
import { connectDB } from "./config/database.js";

const app = express();
const SERVER_PORT = 3003;

// database
connectDB();

// listen
app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][AUTH SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
