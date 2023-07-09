import "dotenv/config";

const MONGODB_URI = process.env.MONGODB_URI;
const AUTH_SERVICE_URL = process.env.AUTH_SERVICE_URL;

export { MONGODB_URI, AUTH_SERVICE_URL };
