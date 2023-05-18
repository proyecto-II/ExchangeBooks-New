import { Router } from "express";
import genreRoutes from "./genre.routes.js";
import userGenreRoutes from "./userGenre.routes.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({ message: "Genre Service is running!" });
});

router.use("/", genreRoutes);
router.use("/user", userGenreRoutes);

export default router;
