import mongoose, { Schema } from "mongoose";

const UserGenreSchema = new Schema({
  userId: {
    type: String,
    required: true,
  },
  genres: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Genre",
    },
  ],
});

export default mongoose.models.UserGenre ||
  mongoose.model("UserGenre", UserGenreSchema);
