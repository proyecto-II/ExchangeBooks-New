import BookService from "../services/book.service.js";

const bookService = new BookService();

/**
 * Metodo que obtiene todos los libros guardados en la base de datos
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return un Json que contiene todos los libros o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function getAllBooks(req, res) {
  try {
    const books = await bookService.getAll();
    return res.status(200).send(books);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que obtiene los libros que un usuario ha publicado
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return un Json que contiene los libros del usuario o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function getBooksByUser(req, res) {
  try {
    const books = await bookService.getBooksByUser(req.params.userId);
    return res.status(200).send(books);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que permite guardar un libro en la base de datos
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return el libro que ha sido guardado o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function createBook(req, res) {
  try {
    const book = await bookService.create(req.body);
    return res.status(201).send(book);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que obtiene los libros segun los parametros que el usuario ha querido filtrar en el frontend
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return un Json que contiene los libros filtrados o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function searchBooks(req, res) {
  try {
    const { q } = req.query;
    const books = await bookService.search(q);
    return res.status(200).send(books);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que obtiene un libro en especifico segun su id
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return una entidad libro o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function getBook(req, res) {
  try {
    const { bookId } = req.params;
    const book = await bookService.getById(bookId);

    return res.status(200).send(book);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que permite editar la publicación que haya realizado un usuario
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return un Json con el libro editado o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function edit(req, res) {
  try {
    console.log(req.params.id);
    const book = await bookService.edit(req.params.id, req.body);
    return res.status(200).json(book);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

/**
 * Metodo que permite eliminar una publicación
 * @param req Es la solicitud del usuario, la cual es recibida por el servidor
 * @param res Respuesta que el servidor envia al usuario
 * @return un mensaje de exito o un mensaje de error si es que la solicitud no se concreto correctamente
 */
export async function deleteBook(req, res) {
  try {
    const books = await bookService.delete(req.params.id);
    return res.status(200).send("Libro eliminado con exito");
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}

export async function filterBooksByGenre(req, res) {
  try {
    const { genres } = req.body;
    const books = await bookService.getByGenres(genres);

    return res.status(200).send(books);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}
