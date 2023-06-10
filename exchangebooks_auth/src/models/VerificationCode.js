import mongoose, { Schema } from "mongoose";

const VerificationCodeSchema = new Schema({
  email: {
    type: String,
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
