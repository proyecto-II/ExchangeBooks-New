import express from "express";
import http from "http";
import { initSocket } from "./config/socket.js";

const app = express();
const server = http.createServer(app);
const SERVER_PORT = 3008;

// middlewares
app.use(express.json());

// socket
initSocket(server);

// listen
server.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][📝CHAT SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
