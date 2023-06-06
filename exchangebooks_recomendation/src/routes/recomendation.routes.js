import { Router } from "express";
import { getRecomentationBooks } from "../controllers/recomendation.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({ message: "Recomendation Service!" });
});

router.post("/books", getRecomentationBooks);

export default router;
