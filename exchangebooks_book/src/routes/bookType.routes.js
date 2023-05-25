import { Router } from "express";
import {
  createBookType,
  getAllBookTypes,
} from "../controllers/bookType.controller.js";

const router = Router();

router.get("/list", getAllBookTypes);
router.post("/create", createBookType);

export default router;
