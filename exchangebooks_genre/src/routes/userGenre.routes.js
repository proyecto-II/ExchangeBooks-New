import { Router } from "express";
import {
  createUserGenre,
  getUserGenres,
  updateUserGenres,
} from "../controllers/userGenre.controller.js";

const router = Router();

// create the user genres
router.post("/create", createUserGenre);

// update user genres
router.put("/update/:userId", updateUserGenres);

// get all genres by user id
router.get("/:email", getUserGenres);

export default router;
