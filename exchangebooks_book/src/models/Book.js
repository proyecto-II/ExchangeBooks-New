import mongoose, { Schema } from "mongoose";

const BookSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  author: {
    type: String,
  },
  description: {
    type: String,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  genres: [
    {
      type: String,
    },
  ],
  type: {
    type: String,
    enum: ["Comic", "Manga", "Libro"],
  },
  images: [
    {
      type: String,
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.models.Book || mongoose.model("Book", BookSchema);
