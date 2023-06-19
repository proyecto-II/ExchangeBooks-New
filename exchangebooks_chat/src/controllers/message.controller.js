import MessageService from "../services/message.service.js";

const messageService = new MessageService();

/**
  * Metodo que obtiene todos los mensajes guardados en la base de datos
  * @param req Es la solicitud del usuario, la cual es recibida por el servidor
  * @param res Respuesta que el servidor envia al usuario
  * @return un Json que contiene todos los mensajes o un mensaje de error si es que la solicitud no se concreto correctamente
  */
export async function getAllMessages(req, res) {
  try {
    const messages = await messageService.getAll();
    return res.status(200).send(messages);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}