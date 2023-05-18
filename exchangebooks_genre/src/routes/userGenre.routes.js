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

// get all user genres by user id
router.get("/:userId", getUserGenres);

export default router;
