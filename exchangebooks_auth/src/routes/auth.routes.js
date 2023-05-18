import { Router } from "express";
import { createUser, editUser } from "../controllers/user.controller.js";

const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Auth Service",
  });
});

router.post("/create", createUser);
router.put("/updateUser", editUser);

export default router;
