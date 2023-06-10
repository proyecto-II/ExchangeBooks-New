import mongoose, { Schema } from "mongoose";

const VerificationCodeSchema = new Schema({
  email: {
    type: String,
    unique: true,
    required: true,
  },
  code: {
    type: Number,
    required: true,
  },
  expires: {
    type: Date,
    required: true,
  },
});

export default mongoose.models.VerificationCodeSchema ||
  mongoose.model("VerificationCode", VerificationCodeSchema);
