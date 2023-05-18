import { Router } from "express";

import {
  createUser,
  getUser,
  verifyUser,
  editUser
} from "../controllers/user.controller.js";


const router = Router();

router.get("/", (req, res) => {
  return res.status(200).json({
    message: "Auth Service",
  });
});

router.post("/create", createUser);
router.put("/updateUser/:id", editUser);
router.post("/verify", verifyUser);
router.get("/get-user/:email", getUser);

export default router;
