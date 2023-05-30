import { Router } from "express";
import { getRecomentationBooks } from "../controllers/recomendation.controller.js";

const router = Router();

router.post("/books", getRecomentationBooks);

export default router;
