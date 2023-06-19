import { Server } from "socket.io";

export function initSocket(server) {
  const io = new Server(server, {
    cors: {
      origin: "*",
    },
  });

  io.on("connection", (socket) => {
    console.log(`[🙍‍♂️NEW CONNECTION] User connected`);

    // los envetos se ejecutan cuando en el cliente se emiten con el nombre correspondiente
    // ingresar al chat con el identificador
    socket.on("join-chat", (chatId) => {
      socket.join(chatId);
    });

    // enviar mensaje con el chatId
    socket.on("send-message", (chatId, message) => {
      io.to(chatId).emit("receive-message", message);
    });
  });
}
