import User from "../models/User.js";

class UserService {

  /**
  * Metodo que permite guardar al usuario en la base de datos
  * @param user Es el usuario con sus atributos
  * @return el usuario guardado en la base de datos
  */
  async create(user) {
    const newUser = new User(user);

    return await newUser.save();
  }

  /**
  * Metodo que verifica que el usuario este registrado
  * @param email Es el email del usuario
  * @return el usuario guardado en la base de datos
  */
  async verify(email) {
    return User.findOne({ email });
  }

  /**
  * Metodo que obtiene un usuario de la base de datos
  * @param email Es el email del usuario
  * @return el usuario guardado en la base de datos
  */
  async get(email) {
    return User.findOne({ email });
  }

  /**
  * Metodo que permite actualizar los datos del usuario
  * @param id Es el id del usuario 
  * @param user Es el usuario con sus atributos
  * @return el usuario actualizado 
  */
  async updateUser(id, user) {
    return User.findByIdAndUpdate(id, user, { new: true });
  }

  /**
  * Metodo obtiene un usuario segun su id
  * @param id Es el id del usuario 
  * @return el usuario obtenido desde la base de datos
  */
  async getById(id) {
    return User.findById(id);
  }
}

export default UserService;
