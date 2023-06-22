import { Router } from "express";
import {
  createChat,
  getChat,
  getUserChats,
} from "../controllers/chat.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Chat Service!",
  });
});

// get user chats
router.get("/user/:userId", getUserChats);

// create chat
router.post("/create", createChat);

// get chat info
router.get("/:chatId", getChat);

export default router;
