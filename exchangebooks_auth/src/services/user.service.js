import User from "../models/User.js";

class UserService {
  constructor() {}

  async create(user) {
    const newUser = new User(user);

    return await newUser.save();
  }

  async verify(email) {
    const user = await User.findOne({ email });

    return user;
  }

  async get(email) {
    const user = await User.findOne({ email });

    return user;
  }
}

export default UserService;
