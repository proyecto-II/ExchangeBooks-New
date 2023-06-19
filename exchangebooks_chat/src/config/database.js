import mongoose from "mongoose";
import { MONGODB_URI } from "./constants.js";

export const connectDB = async () => {
  try {
    await mongoose.connect(MONGODB_URI);
    console.log(`[📒DATABASE][📝CHAT SERVICE] DB Connected`);
  } catch (err) {
    console.log(err);
  }
};
