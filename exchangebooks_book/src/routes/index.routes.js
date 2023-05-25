import { Router } from "express";
import bookRoutes from "./book.routes.js";
import bookTypeRoutes from "./bookType.routes.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({ message: "Book Service is running!" });
});

router.use("/", bookRoutes);
router.use("/type", bookTypeRoutes);

export default router;
