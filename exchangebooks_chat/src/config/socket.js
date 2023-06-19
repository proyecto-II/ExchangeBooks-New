import { Server } from "socket.io";
import Message from "../models/Message.js";

export function initSocket(server) {
  const io = new Server(server, {
    cors: {
      origin: "*",
    },
  });

  io.on("connection", (socket) => {
    console.log(`[🙍‍♂️NEW CONNECTION] User connected`);
    socket.on("new_message", async (data) => {
      try {
        const message = {
          senderId: data.senderId,
          receiverId: data.receiverId,
          message: data.message,
          timestamp: data.timestamp,
        };

        const save = await Message.create(message);
        console.log("Mensaje guardado:", save);
      } catch (error) {
        console.log("Error al guardar el mensaje:", error);
      }
    });
  });
}
