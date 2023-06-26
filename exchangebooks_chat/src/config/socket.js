import { Server } from "socket.io";
<<<<<<< HEAD
import Message from "../models/Message.js";
=======
import MessageService from "../services/message.service.js";

const messageService = new MessageService();
>>>>>>> ft_nicolas_pereira

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
      console.log(`[JOIN CHAT] User joined chat [${chatId}]`);
    });

    // dejar chat con el identificador
    socket.on("leave-chat", (data) => {
      socket.leave(data.chatId);
      console.log(`[LEAVE CHAT] User left chat [${data.chatId}]`);
    });

    // enviar mensaje con el chatId
<<<<<<< HEAD
    socket.on("send-message", (data) => {
      const message = data.message;
      console.log(message);
      
      io.to(data.chatId).emit("receive-message", data);
=======
    socket.on("send-message", async (data) => {
      const { message } = data;
      console.log(
        `[SEND MESSAGE] User sent message to chat [${message.chat}] by user [${message.sender}]`
      );
      // const savedMessage = {
      //   _id: "123",
      //   content: message.content,
      //   sender: message.sender,
      //   chat: message.chat,
      //   createdAt: new Date(),
      // };
      const messageSaved = await messageService.createMessage({
        content: message.content,
        sender: message.sender,
        chat: message.chat,
      });
      socket.to(message.chat).emit("receive-message", messageSaved);
>>>>>>> ft_nicolas_pereira
    });

    // cuando se desconecta un usuario
    socket.on("disconnect", () => {
      console.log(`[⚠DISCONNECT] User disconnected`);
    });
  });
}
