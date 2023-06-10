import { AUTH_SERVICE_URL } from "../config/constants.js";
import Book from "../models/Book.js";
import axios from "axios";

class BookService {
  constructor() {}

  /**
  * Metodo que obtiene todos los libros de la base de datos, igualmente realiza una busqueda de los usuarios para dar una información más detallada de las publicaciones
  * @return lista de los libros guardados en la base de datos
  */
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

  /**
  * Metodo que obtiene un libro en especifico segun su id
  * @param id Es la id del libro
  * @return el libro en especifico
  */
  async getById(id) {
    const book = await Book.findById(id);
    try {
      const { userId,genres, ...others } = book._doc;
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

  /**
  * Metodo que permite guardar un libro en la base de datos
  * @param book Es el libro con todo sus atributos
  * @return el libro guardado en la base de datos
  */
  async create(book) {
    const newBook = new Book(book);
    return await newBook.save();
  }

  /**
  * Metodo que permite editar un libro en especifico
  * @param id Es el id del libro
  * @param book Es el libro con sus atributos editados
  * @return el libro guardado en la base de datos ya editado
  */
  async edit(id, book) {
    return await Book.findByIdAndUpdate(id, book, { new: true });
  }

  /**
  * Metodo que permite eliminar un libro
  * @param id Es el id del libro
  * @return un mensaje de eliminación exitosa
  */
  async delete(id) {
    return await Book.findByIdAndDelete(id);
  }

  /**
  * Metodo que busca todos los libros de un usuario
  * @param userId Es el id del usuario
  * @return la lista de todos los libros que el usuario ha publicado
  */
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

  /**
  * Metodo que busca los libros segun los parametros indicados por el usuario en el frontend
  * @param query es el parametro que permite realizar la busqueda de los libros(puede ser el titulo o el autor)
  * @return la lista de libros filtrada segun los parametros indicados
  */
  async search(query) {
    const books = await Book.find({
      $or: [
        { title: { $regex: query, $options: "i" } },
        { author: { $regex: query, $options: "i" } },
      ],
    });
    const fetchUser = books.map(async (book) => {
      try {
        const { userId,genres, ...others } = book._doc;

        const { data, status } = await axios.get(
          `${AUTH_SERVICE_URL}/user/${userId}`
        );

        const response = await axios.post("http://localhost:3002/list", {
          genres,
        });
        if (status == 200) {
          return { ...others,genres:response.data, user: data.user };
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
