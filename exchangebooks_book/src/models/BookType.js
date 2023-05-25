import mongoose, { Schema } from "mongoose";

const BookTypeSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.models.BookType ||
  mongoose.model("BookType", BookTypeSchema);
