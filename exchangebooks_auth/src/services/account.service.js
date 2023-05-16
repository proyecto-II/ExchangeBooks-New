import Account from "../models/Account.js";

class AccountService {
  constructor() {}

  async create(account) {
    const newAccount = new Account(account);

    return newAccount;
  }
}

export default AccountService;
