import { Router } from "express";
import {
  createChat,
  getChat,
  getChatInfo,
  getUserChats,
  verifyChat,
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

// verify if chat exists
router.post("/verify", verifyChat);

// get chat info
router.post("/info/:chatId", getChatInfo);

// get chat info with messages
router.get("/:chatId", getChat);

export default router;
