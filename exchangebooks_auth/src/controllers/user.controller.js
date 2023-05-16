import UserService from "../services/user.service.js";

const userService = new UserService();

export async function createUser(req, res) {
  try {
    const user = await userService.create({
      ...req.body,
      username: req.body.email,
    });
    return res.status(201).json({
      message: "User created successfully",
      isRegistered: false,
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
