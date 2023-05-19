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
  async updateUser(id,user){
    const updateUser = await User.findByIdAndUpdate(id,user,{new: true})
    return updateUser;
  }
}

export default UserService;
