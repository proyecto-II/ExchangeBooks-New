import UserGenreService from "../services/userGenre.service.js";

const userGenreService = new UserGenreService();

export async function createUserGenre(req, res) {
  try {
    const { userId, genres } = req.body;
    const result = await userGenreService.create(userId, genres);

    return res.status(201).json({
      message: "User genre created successfully",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({
      message: "Error creating user genre",
    });
  }
}

export async function getUserGenres(req, res) {
  try {
    const userGenres = await userGenreService.getUserGenresById(
      req.params.userId
    );
    return res.status(200).json(userGenres);
  } catch (err) {
    return res.status(500).json({
      message: "Error getting user genres",
      error: err,
    });
  }
}

export async function updateUserGenres(req, res) {
  try {
    const userId = req.params.userId;
    const { genres } = req.body;
    const result = await userGenreService.editGenres(userId, genres);

    return res.status(200).json({
      message: "User genres updated successfully",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({
      message: "Error updating user genres",
      error: err,
    });
  }
}
