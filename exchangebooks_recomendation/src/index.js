import express from "express";
import recomendationRoutes from "./routes/recomendation.routes.js";

const app = express();
const SERVER_PORT = process.env.PORT || 3006;

// middlewares
app.use(express.json());

// routes
app.use(recomendationRoutes);

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][💻RECOMENDATION SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
