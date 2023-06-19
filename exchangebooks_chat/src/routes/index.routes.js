import { Router } from "express";
import chatRoutes from "./chat.routes.js";
import messageRoutes from "./message.routes.js";

const router = Router();

router.use("/chat", chatRoutes);
router.use("/message", messageRoutes);

export default router;
