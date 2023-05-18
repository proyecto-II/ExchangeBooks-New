import Genre from "../models/Genre.js";

class GenreService {
  constructor() {}

  async create(genre) {
    const newGenre = new Genre(genre);

    return await newGenre.save();
  }

  async getAll() {
    return await Genre.find();
  }
}

export default GenreService;
