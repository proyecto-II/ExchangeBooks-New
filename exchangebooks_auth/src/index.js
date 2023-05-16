import express from "express";
import { connectDB } from "./config/database.js";
import authRoutes from "./routes/auth.routes.js";

const app = express();
const SERVER_PORT = 3003;

// middlewares
app.use(express.json());

// database
connectDB();

// routes
app.use("/", authRoutes);

// listen
app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][AUTH SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
