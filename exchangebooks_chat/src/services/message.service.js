import Message from "../models/Message.js";

class MessageService {
  constructor() {}

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
