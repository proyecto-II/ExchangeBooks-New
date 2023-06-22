import { getLastMessageDate } from "../helpers/time.helper.js";
import { getUserInfo } from "../helpers/user.helper.js";
import Chat from "../models/chat.js";
import Message from "../models/Message.js";

class ChatService {
  constructor() {}

  async getAllChats() {
    return await Chat.find();
  }

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

  async getLastMessageFromChat(chatId) {
    return await Message.findOne({ chat: chatId }).exec();
  }

  async getUserChats(userId) {
    const data = await Chat.find({ members: { $in: userId } }).exec();

    const chats = data.map(async (chat) => {
      const lastMessage = await this.getLastMessageFromChat(
        chat._id.toString()
      );
      // buscamos dentro de los miembros al otro usuario (diferente al que esta logeado)
      const userMemberId = chat.members.filter(
        (member) => member.toString() !== userId
      );

      const result = await getUserInfo(userMemberId);
      const lastMessageDate = getLastMessageDate(lastMessage.createdAt);

      return {
        ...chat._doc,
        lastMessage: lastMessage.content,
        lastMessageDate,
        nameChat: `${result.user.name} ${result.user.lastname}`,
      };
    });
    const result = await Promise.all(chats);

    return result;
  }
}

export default ChatService;
