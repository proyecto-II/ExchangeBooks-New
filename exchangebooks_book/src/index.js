import express from "express";
import bookRoutes from "./routes/book.routes.js";
import { connectDB } from "./config/database.js";

const app = express();
const SERVER_PORT = 3005;

// database
connectDB();

// middlewares
app.use(express.json());

// routes
app.use("/", bookRoutes);

// listen
app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][📙BOOK SERVICE] Server running on port ${SERVER_PORT}`
  );
});
