import { Server } from "socket.io";

export function initSocket(server) {
  const io = new Server(server, {
    cors: {
      origin: "*",
      methods: ["GET", "POST"],
    },
  });

  io.on("connection", (socket) => {
    console.log(`[🙍‍♂️NEW CONNECTION] User connected`);
  });
}
