import { Router } from "express";
import bookRoutes from "./book.routes.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({ message: "Book Service is running!" });
});

router.use("/", bookRoutes);

export default router;
