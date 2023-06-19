import mongoose, { Schema } from "mongoose";

const ChatSchema = new Schema({
  members: [
    {
      type: String,
      required: true,
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.models.Chat || mongoose.model("Chat", ChatSchema);
