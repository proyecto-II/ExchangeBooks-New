import { formatDate } from "../helpers/time.helper.js";
import { getUserInfo } from "../helpers/user.helper.js";
import Chat from "../models/Chat.js";
import Message from "../models/Message.js";

class ChatService {

  async getAllChats() {
    return await Chat.find();
  }

  async createChat(sender, data) {
    const newChat = new Chat(data);
    const chatSaved = await newChat.save();
    // default message
    const defaultMessage = new Message({
      sender,
      content: "Bienvenido al chat, escribeme para el intercambio👌",
      chat: chatSaved._id,
    });
    await defaultMessage.save();
    return chatSaved;
  }

  async deleteChat(chatId) {
    return await Chat.findByIdAndDelete(chatId);
  }

  async getChat(chatId) {
    return await Chat.findById(chatId);
  }

  async getLastMessageFromChat(chatId) {
    return await Message.findOne({ chat: chatId })
      .sort({ createdAt: -1 })
      .exec();
  }

  async getUserChats(userId) {
    const data = await Chat.find({ members: { $in: userId } })
      .sort({ createdAt: -1 })
      .exec();

    const chats = data.map(async (chat) => {
      const lastMessage = await this.getLastMessageFromChat(
        chat._id.toString()
      );
      // formateamos la fecha del utlimo mensaje
      const lastMessageDate = formatDate(lastMessage.createdAt);

      // buscamos dentro de los miembros al otro usuario (diferente al que esta logeado)
      const userMemberId = chat.members.filter(
        (member) => member.toString() !== userId
      );

      // buscamos la informacion del usuario que no esta autenticado
      const result = await getUserInfo(userMemberId);

      if (!result)
        return {
          ...chat._doc,
          lastMessage: lastMessage.content,
          lastMessageDate,
          nameChat: "Desconocido",
        };

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
