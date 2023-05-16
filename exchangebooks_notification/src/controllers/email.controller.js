import EmailService from "../services/email.service.js";

const emailService = new EmailService();

export async function sendEmail(req, res) {
  try {
    const { email, subject, text } = req.body;
    const result = await emailService.send(email, subject, text);

    return res.status(200).json({
      message: "Email sent",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}
