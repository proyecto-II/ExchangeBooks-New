import { GOOGLE_MAIL_USER } from "../config/constants.js";
import { transporter } from "../config/nodemailer.js";

class EmailService {
  constructor() {}

  async send(to, subject, message) {
    const result = await transporter.sendMail({
      from: `<${GOOGLE_MAIL_USER}>`,
      to,
      subject,
      text: message,
    });

    return result;
  }
}

export default EmailService;
