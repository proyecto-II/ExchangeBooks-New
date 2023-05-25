import BookType from "../models/BookType.js";

class BookTypeService {
  constructor() {}

  async getAll() {
    return await BookType.find();
  }

  async get(id) {
    const book = await BookType.findById(id);
    return book;
  }

  async create(type) {
    const newType = new BookType(type);
    return await newType.save();
  }

  async edit(id, type) {
    return await BookType.findByIdAndUpdate(id, book, { new: true });
  }

  async delete(id) {
    return await BookType.findByIdAndDelete(id);
  }
}

export default BookTypeService;
