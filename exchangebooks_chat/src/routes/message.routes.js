import { Router } from "express";
import { createMessage } from "../controllers/message.controller.js";

const router = Router();

// create message
router.post("/create", createMessage);

export default router;
