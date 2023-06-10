import { AUTH_SERVICE_URL } from "../config/constants.js";
import Book from "../models/Book.js";
import axios from "axios";

class BookService {
  constructor() {}

  async getAll() {
    const books = await Book.find().exec();
    const fetchCategories = books.map(async (book) => {
      try {
        const { genres, userId, ...others } = book._doc;
        const { data, status: genreStatus } = await axios.post(
          "http://localhost:3002/list",
          {
            genres,
          }
        );
        const { data: userData, status: userStatus } = await axios.get(
          `${AUTH_SERVICE_URL}/user/${userId}`
        );

        if (genreStatus === 200 && userStatus === 200) {
          return { ...others, genres: data, user: userData.user };
        }
      } catch (err) {
        return book;
      }
    });
    const result = await Promise.all(fetchCategories);

    return result;
  }

  async getById(id) {
    const book = await Book.findById(id);
    try {
      const { userId, genres, ...others } = book._doc;
      const { data, status } = await axios.get(
        `${AUTH_SERVICE_URL}/user/${book.userId}`
      );
      const response = await axios.post("http://localhost:3002/list", {
        genres,
      });

      if (status == 200) {
        return {
          ...others,
          genres: response.data,
          user: data.user,
        };
      }
    } catch (err) {
      console.log(err);
      return book;
    }
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

  async getBooksByUser(userId) {
    const books = await Book.find({ userId: userId }).exec();
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

  async search(query) {
    const books = await Book.find({
      $or: [
        { title: { $regex: query, $options: "i" } },
        { author: { $regex: query, $options: "i" } },
      ],
    });
    const fetchUser = books.map(async (book) => {
      try {
        const { userId, genres, ...others } = book._doc;

        const { data, status } = await axios.get(
          `${AUTH_SERVICE_URL}/user/${userId}`
        );

        const response = await axios.post("http://localhost:3002/list", {
          genres,
        });
        if (status == 200) {
          return { ...others, genres: response.data, user: data.user };
        }
      } catch (err) {
        return book;
      }
    });

    const result = await Promise.all(fetchUser);
    return result;
  }

  async getByGenres(genres) {
    const filterBooks = await Book.find({
      genres: { $in: genres },
    });

    const fetchUser = filterBooks.map(async (book) => {
      try {
        const { userId, genres, ...others } = book._doc;

        const { data, status } = await axios.get(
          `${AUTH_SERVICE_URL}/user/${userId}`
        );

        const { data: genresData, status: genreStatus } = await axios.post(
          "http://localhost:3002/list",
          {
            genres,
          }
        );
        if (status === 200 && genreStatus === 200) {
          return { ...others, genres: genresData, user: data.user };
        }
      } catch (err) {
        return book;
      }
    });

    const result = await Promise.all(fetchUser);
    return result;
  }
}

export default BookService;
