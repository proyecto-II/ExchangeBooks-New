import MessageService from "../services/message.service.js";

const messageService = new MessageService();

export async function createMessage(req, res) {
  try {
    // create chat
    const message = await messageService.createMessage(req.body);

    return res.status(200).send(message);
  } catch (e) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}
