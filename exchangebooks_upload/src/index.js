import express from "express";
import uploadRoutes from "./routes/upload.routes.js";
import bodyParser from "body-parser";

const app = express();
const SERVER_PORT = 3005;

// midlewares
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use("/", uploadRoutes);

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][📂UPLOAD SERVICE] Server listening on port ${SERVER_PORT}`
  );
});
