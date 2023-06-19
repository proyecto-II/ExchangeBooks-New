import User from "../models/User.js";

class UserService {
  constructor() {}

  /**
  * Metodo que permite guardar al usuario en la base de datos
  * @param user Es el usuario con todo sus atributos
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
    const user = await User.findOne({ email });

    return user;
  }

  /**
  * Metodo que obtiene un usuario de la base de datos
  * @param email Es el email del usuario
  * @return el usuario guardado en la base de datos
  */
  async get(email) {
    const user = await User.findOne({ email });

    return user;
  }

  /**
  * Metodo que permite actualizar los datos del usuario
  * @param id Es el id del usuario 
  * @param user Es el usuario con todo sus atributos
  * @return el usuario actualizado 
  */
  async updateUser(id, user) {
    const updateUser = await User.findByIdAndUpdate(id, user, { new: true });
    return updateUser;
  }

  /**
  * Metodo obtiene un usuario segun su id
  * @param id Es el id del usuario 
  * @return el usuario obtenido desde la base de datos
  */
  async getById(id) {
    const user = await User.findById(id);
    return user;
  }
}

export default UserService;
