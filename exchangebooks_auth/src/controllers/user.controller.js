import UserService from "../services/user.service.js";
import axios from "axios";
import bcrypt from "bcrypt";
import { EMAIL_SERVICE_URL } from "../config/constants.js";
import AccountService from "../services/account.service.js";
import {
  generateVerficationCode,
  genereteExpiresDate,
} from "../utils/methods.js";

const accountService = new AccountService();

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

    const response = await axios.post(`${EMAIL_SERVICE_URL}/email`, {
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

export async function editUser(req, res) {
  try {
    const user = await userService.updateUser(req.params.id, req.body);
    return res.status(200).json(user);
  } catch (err) {
    return res.status(500).json({ message: "Server error" });
  }
}

export async function getUserById(req, res) {
  try {
    const user = await userService.getById(req.params.id);
    if (user) return res.status(200).json({ user });

    return res.status(404).json({ message: "User not found" });
  } catch (err) {
    return res.status(500).json({ message: "Server error", err });
  }
}

export async function resetPassword(req, res) {
  try {
    const { email } = req.body;
    console.log(email);
    // generate code
    const code = await generateVerficationCode();
    const codeExpires = await genereteExpiresDate();

    // create document in database
    const account = await userService.createVerificationCode({
      email,
      code,
      expires: codeExpires,
    });

    // send email
    const response = await axios.post(`${EMAIL_SERVICE_URL}/email`, {
      email,
      subject: "Reset Password",
      text: `Tu codigo de vericacion para resetear tu contraseña es: ${code}`,
    });

    return res.status(200).json({
      message: "Verification code sent successfully",
    });
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

export async function validateVerificationCode(req, res) {
  try {
    const { code } = req.params;
    const isValidate = await userService.validateVerificationCode(code);

    if (!isValidate) return res.status(404).json({ isValidate: false });

    return res.status(200).json({ isValidate: true });
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}
