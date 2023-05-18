import mongoose, { Schema } from "mongoose";

const AccountSchema = new Schema({
  googleId: {
    type: String,
    required: true,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
});

export default mongoose.models.Account ||
  mongoose.model("Account", AccountSchema);
