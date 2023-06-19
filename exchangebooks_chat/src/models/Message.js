import mongoose, { Schema } from "mongoose";

const MessageSchema = new Schema({
  senderId: {
    type: String,
    required: true,
  },
  receiverId: {
    type: String,
  },
  message: {
    type: String,
  },
  timestamp: {
    type: String,
    required: true,
    unique: true,
  },
});

export default mongoose.models.Message || mongoose.model("Message", MessageSchema);
