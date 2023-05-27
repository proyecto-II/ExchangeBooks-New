import { Router } from "express";
import { uplodImage } from "../config/multer.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Upload Service!!!",
  });
});

// http://localhost:3000/api/upload/files?folder=${value}
router.post("/files", uplodImage.array("files", 3), (req, res, next) => {
  return res.status(200).send({
    message: "Upload files!!!",
    files: req.files,
  });
});

// http://localhost:3000/api/upload/file?folder=${value}
router.post("/file", uplodImage.single("files"), (req, res, next) => {
  return res.status(200).json({
    location: req.file.location,
  });
});

export default router;
