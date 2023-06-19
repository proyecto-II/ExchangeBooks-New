import { Router } from "express";
import {
  getAllMessages,
} from "../controllers/message.controller.js";

const router = Router();

router.get("/list", getAllMessages);

export default router;
