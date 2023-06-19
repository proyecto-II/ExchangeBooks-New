import ChatService from "../services/chat.service.js";
import MessageService from "../services/message.service.js";

const chatService = new ChatService();
const messageService = new MessageService();

export async function getChat(req, res) {
  try {
    const { chatId } = req.params;
    // get chat
    const chat = await chatService.getChat(chatId);

    // get messages
    const messages = await messageService.getMessagesByChat(chatId);

    return res.status(200).send({
      ...chat,
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
    // create chat
    const chat = await chatService.createChat(req.body);

    return res.status(200).send(chat);
  } catch (e) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}