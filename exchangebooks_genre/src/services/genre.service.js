import Genre from "../models/Genre.js";

class GenreService {

  async create(genre) {
    const newGenre = new Genre(genre);

    return await newGenre.save();
  }

  async getAll() {
    return await Genre.find();
  }

  async getGenresByList(list) {
    const genres = await Genre.find().where("_id").in(list).exec();

    return genres;
  }
}

export default GenreService;
