import { Router } from "express";
import { sendEmail } from "../controllers/email.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({ message: "Notification Service" });
});

router.post("/email", sendEmail);

export default router;
