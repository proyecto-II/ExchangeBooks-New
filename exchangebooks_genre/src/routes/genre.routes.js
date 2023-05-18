import { Router } from "express";
import { createGenre, getAllGenres } from "../controllers/genre.controller.js";

const router = Router();

router.post("/create", createGenre);
router.get("/list", getAllGenres);

export default router;
