import Message from "../models/Message.js";

class MessageService {
  constructor() {}

  /**
  * Metodo que obtiene todos los mensajes de la base de datos
  * @return lista de mensajes guardados en la base de datos
  */
  async getAll() {
    return await Message.find();
  }

  async createMessage(message) {
    const newMessage = new Message(message);
    return await newMessage.save();
  }

  async getMessagesByUser(userId) {
    return await Message.find({ sender: userId });
  }

  async getMessagesByChat(chatId) {
    return await Message.find({ chat: chatId });
  }
}

export default MessageService;
