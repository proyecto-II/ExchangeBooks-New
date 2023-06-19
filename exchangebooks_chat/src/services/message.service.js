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
}
export default MessageService;