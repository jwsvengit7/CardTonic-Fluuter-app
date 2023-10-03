class Request {
  static Map<String, dynamic> traderequest(double amount, String coin) {
    return {
      "amount": amount,
      "coin": coin,
    };
  }

  static Map<String, String> createRequest(
      String username, String email, String password) {
    return {
      "username": username, 
      "email": email,
      "password": password
     };
  }

  static Map<String, String> loginRequest(String email, String password) {
    return {
      "email": email, 
      "password": password
      };
  }

  static Map<String, String> createBankAccount(
      String accountNumber, String bankName, String accountName) {
    return {
      "accountNumber": accountNumber,
      "bankName": bankName,
      "accountName": accountName,
    };
  }

  static Map<String, String> getAccountName(
      String accountNumber, String bankCode) {
    return {
      'account_number': accountNumber,
      'bank_code': bankCode,
      'currency': 'NGN',
    };
  }

  static Map<String, String> verifyOtp(var email, var otp) {
    return {
      "email": email,
      "otp": otp
     };
  }

  static Map<String, dynamic> createGiftcard(var name, var amount) {
    return {
      "name": name, 
      "amount": amount
      };
  }
}

