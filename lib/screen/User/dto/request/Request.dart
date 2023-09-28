import 'dart:ffi';

class Request {
  static Map<String, dynamic> traderequest(Double amount, String coin) {
    return {
      "amount": amount,
      "coin": coin,
    };
  }

  static Map<String, dynamic> createRequest(
      String username, String email, String password) {
    return {"username": username, "email": email, "password": password};
  }

  static Map<String, dynamic> loginRequest(String email, String password) {
    return {"email": email, "password": password};
  }

  static Map<String, dynamic> createBankAccount(
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
    return {"email": email, "otp": otp};
  }

  static Map<String, String> createGiftcard(var name, var amount) {
    return {"name": name, "amount": amount};
  }
}

class Home {


Map<String, String>  r =  Request.createGiftcard("2","2");
}
