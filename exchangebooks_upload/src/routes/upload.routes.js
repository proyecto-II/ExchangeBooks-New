import { Router } from "express";
import { uplodImage } from "../config/multer.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Upload Service!!!",
  });
});

// http://localhost:3000/upload/files?folder=${value}
router.post("/files", uplodImage.array("files", 3), (req, res, next) => {
  return res.status(200).json({
    message: "Upload files!!!",
    files: req.files,
  });
});

export default router;
