import Book from "../models/Book.js";

class BookService {
  constructor() {}

  async getAll() {
    return await Book.find();
  }

  async get(id) {
    const book = await Book.findById(id);
    return book;
  }

  async create(book) {
    const newBook = new Book(book);
    return await newBook.save();
  }

  async edit(id, book) {
    return await Book.findByIdAndUpdate(id, book, { new: true });
  }

  async delete(id) {
    return await Book.findByIdAndDelete(id);
  }
}

export default BookService;
