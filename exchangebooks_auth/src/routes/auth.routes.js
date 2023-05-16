import { Router } from "express";
import { createUser, verifyUser } from "../controllers/user.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Auth Service",
  });
});

router.post("/create", createUser);
router.post("/verify", verifyUser);

export default router;
