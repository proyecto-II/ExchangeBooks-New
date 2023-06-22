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
      console.log(`[JOIN CHAT] User joined chat [${chatId}]`);
      socket.join(chatId);
    });

    // enviar mensaje con el chatId
    socket.on("send-message", (data) => {
      const { message } = data;
      console.log(
        `[SEND MESSAGE] User sent message to chat [${message.chat}] by user [${message.sender}]`
      );
      const savedMessage = {
        _id: "123",
        content: message.content,
        sender: message.sender,
        chat: message.chat,
        createdAt: new Date(),
      };
      io.to(message.chat).emit("receive-message", savedMessage);
    });

    // cuando se desconecta un usuario
    socket.on("disconnect", () => {
      console.log(`[⚠DISCONNECT] User disconnected`);
    });
  });
}
