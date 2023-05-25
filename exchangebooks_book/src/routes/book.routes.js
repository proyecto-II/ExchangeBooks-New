import { Router } from "express";
import { getAllBooks } from "../controllers/book.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Book service running!",
  });
});

router.get("/list", getAllBooks);

export default router;
