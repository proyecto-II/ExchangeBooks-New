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

const services = [
  { name: "Notification", url: `${API_URL}/notification` },
  { name: "Genre", url: `${API_URL}/genre` },
  { name: "Auth", url: `${API_URL}/auth` },
  { name: "Upload", url: `${API_URL}/upload` },
  { name: "Book", url: `${API_URL}/book` },
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

app.use(`${API_NAME}/notification`, proxy(`${API_HOST}:3001`));
app.use(`${API_NAME}/genre`, proxy(`${API_HOST}:3002`));
app.use(`${API_NAME}/auth`, proxy(`${API_HOST}:3003`));
app.use(`${API_NAME}/upload`, proxy(`${API_HOST}:3004`));
app.use(`${API_NAME}/book`, proxy(`${API_HOST}:3005`));

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
