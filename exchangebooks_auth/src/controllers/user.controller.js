import UserService from "../services/user.service.js";

const userService = new UserService();

export async function createUser(req, res) {
  try {
    const user = await userService.create(req.body);
    return res.status(201).json(user);
  } catch (err) {
    return res.status(500).json({ message: "Server error" });
  }
}
