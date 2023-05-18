import UserService from "../services/user.service.js";
import axios from "axios";
import bcrypt from "bcrypt";

const userService = new UserService();

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

export async function getUser(req, res) {
  try {
    const user = await userService.get(req.params.email);
    if (user) return res.status(200).send(user);

    return res.status(404).json({ message: "User not found" });
  } catch (err) {
    return res.status(500).json({ message: "Server error", err });
  }
}
