import nodemailer from "nodemailer";
import { GOOGLE_MAIL_PASSWORD, GOOGLE_MAIL_USER } from "./constants.js";

export const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: GOOGLE_MAIL_USER,
    pass: GOOGLE_MAIL_PASSWORD,
  },
  secure: true,
  tls: {
    rejectUnauthorized: false,
  },
});

transporter.verify().then(() => {
  console.log("[💾GMAIL][✉NOTIFICATION SERVICE] Ready for send emails");
});
