import Book from "../models/Book.js";
import axios from "axios";

class BookService {
  constructor() {}

  async getAll() {
    const books = await Book.find().exec();
    const fetchCategories = books.map(async (book) => {
      try {
        const { genres, ...others } = book._doc;
        const response = await axios.post("http://localhost:3002/list", {
          genres,
        });

        return { ...others, genres: response.data };
      } catch (err) {
        return null;
      }
    });
    const result = await Promise.all(fetchCategories);

    return result;
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

  async getBooksByUser(userId){
    const books = await Book.find({userId:userId}).exec();
    const fetchCategories = books.map(async (book) => {
      try {
        const { genres, ...others } = book._doc;
        const response = await axios.post("http://localhost:3002/list", {
          genres,
        });

        return { ...others, genres: response.data };
      } catch (err) {
        return null;
      }
    });
    const result = await Promise.all(fetchCategories);
    return result;
  }
}

export default BookService;
