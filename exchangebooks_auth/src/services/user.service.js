import User from "../models/User.js";
import VerificationCode from "../models/VerificationCode.js";

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

  async updateUser(id, user) {
    const updateUser = await User.findByIdAndUpdate(id, user, { new: true });
    return updateUser;
  }

  async getById(id) {
    const user = await User.findById(id);
    return user;
  }

  async createVerificationCode(verificationCode) {
    const newVerificationCode = new VerificationCode(verificationCode);

    return await newVerificationCode.save();
  }

  async validateVerificationCode(code) {
    const verificationCode = await VerificationCode.findOne({ code });

    if (!verificationCode) {
      return false;
    }

    if (verificationCode.expires < Date.now()) {
      return false;
    }

    return true;
  }
}

export default UserService;
