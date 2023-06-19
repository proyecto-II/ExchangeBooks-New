import { Router } from "express";
import { createChat, getChat } from "../controllers/chat.controller.js";

const router = Router();

// create chat
router.post("/create", createChat);

// get chat info
router.get("/:chatId", getChat);

export default router;
