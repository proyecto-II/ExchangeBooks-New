import express from "express";
import notificationService from "./routes/notification.service.js";

const app = express();
const SERVER_PORT = 3001;

app.use(express.json());

// routes
app.use("/", notificationService);

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][📰EMAIL SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
