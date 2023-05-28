import { Router } from "express";
import { getRecomentationBooks } from "../controllers/recomendation.controller";

const router = Router();

router.post("/recomendation", getRecomentationBooks);

export default router;
