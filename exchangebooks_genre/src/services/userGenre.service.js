import UserGenre from "../models/UserGenre.js";

class UserGenreService {
  
  async create(userId, genres) {
    const userGenres = new UserGenre({
      userId,
      genres,
    });

    return await userGenres.save();
  }

  async getUserGenresByEmail(userId) {
    return await UserGenre.findOne({ userId }).populate("genres").exec();
  }

  async editGenres(userId, genres) {
    return await UserGenre.findOneAndUpdate(
      { userId },
      { genres },
      { new: true }
    );
  }
}

export default UserGenreService;
