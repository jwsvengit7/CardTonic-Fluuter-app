import 'dart:convert';
import 'package:cardmonix/dto/request/Request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardmonix/helpers/constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<http.Response> createAccount(
      {var email, var password, var username}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/auth/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Request.createRequest(username, email, password)),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }

  Future<http.Response> verifyOtp({var email, var otp}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/auth/otp_verify"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Request.verifyOtp(email, otp)),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      return http.Response('Error: $e', 500);
    }
  }

  Future<http.Response> login({var email, var password}) async {
    try {
      final response = await http.post(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Request.loginRequest(email, password)),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      print('Error: $e');
      return http.Response('Error: $e', 500);
    }
  }

  Future<http.Response> fetchCoins(int pageNo, int pageSize) {
    return http.get(
      Uri.parse(
          "${Constants.getBackendUrl()}/api/v1/user/veiw-coin?pageNo=$pageNo&pageSize=$pageSize"),
    );
  }

// COIN

  Future<http.Response> fetchUserDetails(var savedToken) async {
    return http.get(
      Uri.parse("${Constants.getBackendUrl()}/api/v1/user/user-details"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<http.Response> getCoin(var savedToken, String coin) async {
    return http.get(
      Uri.parse(
          "${Constants.getBackendUrl()}/api/v1/user/getcoinByName?coin=$coin"),
      headers: {
        'Authorization': 'Bearer $savedToken',
      },
    );
  }

  Future<http.Response> getAllGiftcard(var saveToken) {
    return http.get(
      Uri.parse("${Constants.getBackendUrl()}/api/v1/giftcards/all-giftcard"),
      headers: {
        'Authorization': 'Bearer $saveToken',
      },
    );
  }

  Future<http.Response> createGiftcard(var saveToken, var name, var amount) {
    return http.post(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/giftcards//create-giftcard"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        },
        body: jsonEncode(Request.createGiftcard(name, amount)));
  }

  Future<http.Response> getWallet(var saveToken) {
    return http.get(
        Uri.parse("${Constants.getBackendUrl()}/api/v1/user/wallets"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  // Account Details

  Future<http.Response> get_account(var saveToken, var id) async {
    return http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/account/get-my-account/$id"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  Future<http.Response> getAccountName(String accountNumber, String bankCode) {
    return http.get(
      Uri.parse("https://api.paystack.co/bank/resolve").replace(
          queryParameters: Request.getAccountName(accountNumber, bankCode)),
      headers: {
        'Authorization':
            'Bearer sk_test_652cb496246c20a1a51456bdf96c12485b37cf7c',
      },
    );
  }

  Future<http.Response> saveAccount(
    String saveToken,
    String accountNumber,
    String bankName,
    String accountName,
  ) async {
    final Uri uri =
        Uri.parse("${Constants.getBackendUrl()}/api/v1/account/saveAccount");

    final headers = {
      'Authorization': 'Bearer $saveToken',
      'Content-Type': 'application/json', // Specify the content type
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(
          Request.createBankAccount(accountNumber, bankName, accountName)),
    );

    return response;
  }

// DEPOSIT SERVICE

  Future<http.Response> get_deposit(var saveToken) {
    return http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/deposit/get-deposit-byUser"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  Future<http.Response> getAlldeposit(var saveToken) {
    return http.get(
        Uri.parse(
            "${Constants.getBackendUrl()}/api/v1/deposit/get-all-deposit"),
        headers: {
          'Authorization': 'Bearer $saveToken',
        });
  }

  Future<http.Response> tradeCoin(
      String saveToken, var coin, var amount) async {
    try {
      var response = await http.post(
          Uri.parse("${Constants.getBackendUrl()}/api/v1/deposit/buy-coin"),
          headers: {
            'Authorization': 'Bearer $saveToken',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(Request.traderequest(amount, coin)));
      if (response.statusCode == 201) {
        return response;
      } else {
        return http.Response(response.body, response.statusCode);
      }
    } catch (e) {
      return http.Response('Error: $e', 500);
    }
  }

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
