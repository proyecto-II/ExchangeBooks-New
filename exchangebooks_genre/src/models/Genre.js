import mongoose, { Schema } from "mongoose";

const GenreSchema = new Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.models.Genre || mongoose.model("Genre", GenreSchema);
