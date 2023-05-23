import express from "express";
import uploadRoutes from "./routes/upload.routes.js";

const app = express();
const SERVER_PORT = 3005;

app.use("/", uploadRoutes);

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][📂UPLOAD SERVICE] Server listening on port ${SERVER_PORT}`
  );
});
