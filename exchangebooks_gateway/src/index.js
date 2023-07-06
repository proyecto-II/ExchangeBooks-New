import express from "express";
import morgan from "morgan";
import proxy from "express-http-proxy";
import CheckService from "./services/check.service.js";
import "dotenv/config.js";

const app = express();
const SERVER_PORT = 3000;
const API_HOST = process.env.API_HOST || `http://localhost`;
const API_NAME = "/api";
const API_URL = `${API_HOST}${API_NAME}`;
const checkService = new CheckService();

// servers
const NOTIFICATION_SERVICE_URL =
  process.env.NOTIFICATION_SERVICE_URL || `${API_HOST}:3001`;
const GENRE_SERVICE_URL = process.env.GENRE_SERVICE_URL || `${API_HOST}:3002`;
const AUTH_SERVICE_URL = process.env.AUTH_SERVICE_URL || `${API_HOST}:3003`;
const UPLOAD_SERVICE_URL = process.env.UPLOAD_SERVICE_URL || `${API_HOST}:3004`;
const BOOK_SERVICE_URL = process.env.BOOK_SERVICE_URL || `${API_HOST}:3005`;
const RECOMENDATION_SERVICE_URL =
  process.env.RECOMENDATION_SERVICE_URL || `${API_HOST}:3006`;
const CHAT_SERVICE_URL = process.env.CHAT_SERVICE_URL || `${API_HOST}:3008`;

const services = [
  { name: "Notification", url: `${NOTIFICATION_SERVICE_URL}/notification` },
  { name: "Genre", url: `${GENRE_SERVICE_URL}/genre` },
  { name: "Auth", url: `${AUTH_SERVICE_URL}/auth` },
  { name: "Upload", url: `${UPLOAD_SERVICE_URL}/upload` },
  { name: "Book", url: `${BOOK_SERVICE_URL}/book` },
  {
    name: "Recomentadation",
    url: `${RECOMENDATION_SERVICE_URL}/recomendation`,
  },
  { name: "Chat", url: `${CHAT_SERVICE_URL}/chat` },
];

// middlewares
app.use(express.json());
app.use(
  morgan(":method :url :status :res[content-length] - :response-time ms")
);

// routes
app.get("/", (req, res) => {
  return res.status(200).json({ message: "Gateway service" });
});

app.use(`${API_NAME}/notification`, proxy(NOTIFICATION_SERVICE_URL));
app.use(`${API_NAME}/genre`, proxy(GENRE_SERVICE_URL));
app.use(`${API_NAME}/auth`, proxy(AUTH_SERVICE_URL));
app.use(`${API_NAME}/upload`, proxy(UPLOAD_SERVICE_URL));
app.use(`${API_NAME}/book`, proxy(BOOK_SERVICE_URL));
app.use(`${API_NAME}/recomendation`, proxy(RECOMENDATION_SERVICE_URL));
app.use(`${API_NAME}/chat`, proxy(CHAT_SERVICE_URL));

app.get("/services", async (req, res) => {
  const results = await checkService.check(services);

  const successServices = results.filter((service) => service.status === 200);
  const errorServices = results.filter((service) => service.status === 400);

  return res.status(200).json({
    message: "Gateway service",
    services: {
      success: successServices,
      error: errorServices,
    },
  });
});

app.listen(SERVER_PORT, () => {
  console.log(
    `[🔋LISTEN][⚡GATEWAY SERVICE] Server running on port ${SERVER_PORT}`
  );
});
