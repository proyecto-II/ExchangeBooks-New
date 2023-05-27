import { Router } from "express";
import {
  createGenre,
  getAllGenres,
  getGenresByList,
} from "../controllers/genre.controller.js";

const router = Router();

router.post("/create", createGenre);
router.get("/list", getAllGenres);
router.post("/list", getGenresByList);

export default router;
