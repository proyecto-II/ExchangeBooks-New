import { Router } from "express";
import {
  createBook,
  getAllBooks,
  getBook,
  getBooksByUser,
  searchBooks,
  filterBooksByGenre,
} from "../controllers/book.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Book service running!",
  });
});

router.get("/list", getAllBooks);
router.post("/create", createBook);
router.get("/list/:userId", getBooksByUser);
router.get("/search", searchBooks);
router.get("/:bookId", getBook);
router.post("/list/genres", filterBooksByGenre);

export default router;
