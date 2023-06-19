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

    // los eventos se ejecutan cuando en el cliente se emiten con el nombre correspondiente
    // ingresar al chat con el identificador
    socket.on("join-chat", (chatId) => {
      socket.join(chatId);
    });

    // enviar mensaje con el chatId
    socket.on("send-message", (data) => {
      const message = data.message;
      console.log(message);
      
      io.to(data.chatId).emit("receive-message", data);
    });

    // cuando se desconecta un usuario
    socket.on("disconnect", () => {
      console.log(`[⚠DISCONNECT] User disconnected`);
    });
  });
}
