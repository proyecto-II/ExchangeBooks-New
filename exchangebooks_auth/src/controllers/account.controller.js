import AccountService from "../services/account.service.js";

const accountService = new AccountService();

export async function createAccount(req, res) {
  try {
    const account = await accountService.create(req.body);
    return res.status(201).json({ messsage: "Account created", account });
  } catch (err) {
    return res
      .status(500)
      .json({ message: "Error creating account", error: err });
  }
}
