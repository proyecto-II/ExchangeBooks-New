import express from "express";
import { connectDB } from "./config/database.js";
import indexRoutes from "./routes/index.routes.js";

const app = express();
const SERVER_PORT = 3002;

app.use(express.json());

// database
connectDB();

// routes
app.use("/", indexRoutes);

// listen
app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][GENRE SERVICE] Server running on port ${SERVER_PORT}`
  );
});
