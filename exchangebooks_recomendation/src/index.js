import express from "express";

const app = express();
const SERVER_PORT = process.env.PORT || 3006;

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][💻RECOMENDATION SERVICE] Server is running on port ${SERVER_PORT}`
  );
});
