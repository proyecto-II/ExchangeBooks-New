import BookService from "../services/book.service.js";

const bookService = new BookService();

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
