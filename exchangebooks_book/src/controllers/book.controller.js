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

export async function getBooksByUser(req,res){
  try{
    const books = await bookService.getBooksByUser(req.params.userId);
    return res.status(200).send(books);
  }catch(err){
    return res.status(500).json({
      message: err.message,
    });
  }
}

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
