import express from "express";
import morgan from "morgan";
import proxy from "express-http-proxy";
import CheckService from "./services/check.service.js";

const app = express();
const SERVER_PORT = 3000;
const API_HOST = "http://localhost";
const API_NAME = "/api";
const API_URL = `${API_HOST}:${SERVER_PORT}${API_NAME}`;
const checkService = new CheckService();

// servers
const NOTIFICATION_SERVICE_URL =
  process.env.NOTIFICATION_SERVICE_URL || API_HOST;
const GENRE_SERVICE_URL = process.env.GENRE_SERVICE_URL || API_HOST;
const AUTH_SERVICE_URL = process.env.AUTH_SERVICE_URL || API_HOST;
const UPLOAD_SERVICE_URL = process.env.UPLOAD_SERVICE_URL || API_HOST;
const BOOK_SERVICE_URL = process.env.BOOK_SERVICE_URL || API_HOST;
const RECOMENDATION_SERVICE_URL =
  process.env.RECOMENDATION_SERVICE_URL || API_HOST;
const CHAT_SERVICE_URL = process.env.CHAT_SERVICE_URL || API_HOST;

const services = [
  { name: "Notification", url: `${API_URL}/notification` },
  { name: "Genre", url: `${API_URL}/genre` },
  { name: "Auth", url: `${API_URL}/auth` },
  { name: "Upload", url: `${API_URL}/upload` },
  { name: "Book", url: `${API_URL}/book` },
  { name: "Recomentadation", url: `${API_URL}/recomendation` },
  { name: "Chat", url: `${API_URL}/chat` },
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

app.use(`${API_NAME}/notification`, proxy(`${NOTIFICATION_SERVICE_URL}:3001`));
app.use(`${API_NAME}/genre`, proxy(`${GENRE_SERVICE_URL}:3002`));
app.use(`${API_NAME}/auth`, proxy(`${AUTH_SERVICE_URL}:3003`));
app.use(`${API_NAME}/upload`, proxy(`${UPLOAD_SERVICE_URL}:3004`));
app.use(`${API_NAME}/book`, proxy(`${BOOK_SERVICE_URL}:3005`));
app.use(
  `${API_NAME}/recomendation`,
  proxy(`${RECOMENDATION_SERVICE_URL}:3006`)
);
app.use(`${API_NAME}/chat`, proxy(`${CHAT_SERVICE_URL}:3008`));

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
