import GenreService from "../services/genre.service.js";

const genreService = new GenreService();

export async function createGenre(req, res) {
  try {
    const result = await genreService.create({ ...req.body });

    return res.status(201).json({
      message: "Genre created successfully",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({
      message: "Error creating genre",
    });
  }
}

export async function getAllGenres(req, res) {
  try {
    const result = await genreService.getAll();

    return res.status(200).json({
      message: "Get All genres",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({
      message: "Error fetching genres",
    });
  }
}
