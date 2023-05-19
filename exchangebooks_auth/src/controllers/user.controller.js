import UserService from "../services/user.service.js";
import axios from "axios";
import bcrypt from "bcrypt";

const userService = new UserService();

  /**
  * Metodo que permite guardar un usuario en la base de datos Mongo, es aquel que permite registrar al usuario en la aplicación
  * @param req Es la solicitud del usuario, la cual es recibida por el servidor
  * @param res Respuesta que el servidor envia al usuario
  * @return un Json que contiene el mensaje dependiendo si se guardo el usuario corrrectamente y el usuario en si.
  */
export async function createUser(req, res) {
  try {
    const { password, ...others } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await userService.create({
      ...others,
      password: hashedPassword,
      username: req.body.email,
    });

    const response = await axios.post("http://localhost:3001/email", {
      email: req.body.email,
      subject: "Bienvenido a Exchangebooks",
      text: "Te damos la bienvenida a Exchangebooks, puedes acceder a nuestra plataforma con tus credenciales",
    });

    if (response.status !== 200)
      return res.status(201).json({
        message: "User created successfully",
        isRegistered: true,
        sendEmail: false,
        user,
      });

    return res.status(201).json({
      message: "User created successfully",
      isRegistered: true,
      sendEmail: true,
      user,
    });
  } catch (err) {
    return res.status(500).json({ message: "Server error", err });
  }
}

  /**
  * Metodo que permite verificar un usuario
  * @param req Es la solicitud del usuario, la cual es recibida por el servidor
  * @param res Respuesta que el servidor envia al usuario
  * @return un mensaje y un estado dependiendo si el usuario es encontrado en la base de datos, y a la vez si esta registrado en el sistema
  */
export async function verifyUser(req, res) {
  try {
    const user = await userService.verify(req.body.email);
    if (!user)
      return res
        .status(404)
        .json({ message: "User not found", isRegistered: false });

    return res.status(200).json({ message: "User found", isRegistered: true });
  } catch (err) {
    return res.status(500).json({ message: "Server error", err });
  }
}


  /**
  * Metodo que permite actualizar los datos del usuario
  * @param req Es la solicitud del usuario, la cual es recibida por el servidor
  * @param res Respuesta que el servidor envia al usuario
  * @return una respuesta con el estado 200 y el usuario en formato Json para que el usuario pueda obtener los datos actualizados
  */
export async function getUser(req, res) {
  try {
    const user = await userService.get(req.params.email);
    if (user) return res.status(200).send(user);

    return res.status(404).json({ message: "User not found" });
  } catch (err) {
    return res.status(500).json({ message: "Server error", err });
  }
}

  /**
  * Metodo que permite actualizar los datos del usuario
  * @param req Es la solicitud del usuario, la cual es recibida por el servidor
  * @param res Respuesta que el servidor envia al usuario
  * @return una respuesta con el estado 200 y el usuario en formato Json para que el usuario pueda obtener los datos actualizados
  */
export async function editUser(req, res) {
  try {
    const user = await userService.updateUser(req.params.id,req.body);
    return res.status(200).json(user);
  } catch (err) {
    return res.status(500).json({ message: "Server error" });
  }
}