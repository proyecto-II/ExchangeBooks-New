import ChatService from "../services/chat.service.js";
import MessageService from "../services/message.service.js";

const chatService = new ChatService();
const messageService = new MessageService();

/**
 * Metodo que obtiene la informacion de un chat y sus mensajes
 * @return lista de mensajes guardados en la base de datos
 */
export async function getChat(req, res) {
  try {
    const { chatId } = req.params;
    // get chat
    const chat = await chatService.getChat(chatId);

    // get messages
    const messages = await messageService.getMessagesByChat(chatId);

    return res.status(200).json({
      ...chat._doc,
      messages,
    });
  } catch (e) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}

export async function createChat(req, res) {
  try {
    const { sender, members } = req.body;
    // create chat
    const data = { members };
    const chat = await chatService.createChat(sender, data);

    return res.status(200).send(chat);
  } catch (e) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}

export async function getUserChats(req, res) {
  try {
    const { userId } = req.params;
    const userChats = await chatService.getUserChats(userId);

    return res.status(200).send(userChats);
  } catch (error) {
    return res.status(500).json({
      message: error,
    });
  }
}

export async function getChatInfo(req, res) {
  try {
    const { chatId } = req.params;
    const { userId } = req.body;
    // get chat
    const chatInfo = await chatService.getChatInfoById(chatId, userId);

    return res.status(200).send(chatInfo);
  } catch (e) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}

export async function verifyChat(req, res) {
  try {
    const { userId, anotherUserId } = req.body;
    const userChats = await chatService.verifyIfUserHaveChatWithAnotherUser(
      userId,
      anotherUserId
    );

    if (!userChats) return res.status(200).json({ verify: false });

    return res.status(200).json({
      verify: true,
      chatId: userChats._id,
    });
  } catch (error) {
    return res.status(500).json({
      message: error,
    });
  }
}
