import Chat from "../models/chat.js";

class ChatService {
  constructor() {}

  async createChat(chat) {
    const newChat = new Chat(chat);
    return await newChat.save();
  }

  async deleteChat(chatId) {
    return await Chat.findByIdAndDelete(chatId);
  }

  async getChat(chatId) {
    return await Chat.findById(chatId);
  }
}

export default ChatService;
