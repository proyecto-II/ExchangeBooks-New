import User from "../models/User.js";

class UserService {
  constructor() {}

  async create(user) {
    const newUser = new User(user);

    return await newUser.save();
  }
}

export default UserService;
