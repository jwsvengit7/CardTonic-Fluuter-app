class AccountInfoResponse {
  final String message;
  final AccountInfo data;
  final int dateTime;

  AccountInfoResponse({
    required this.message,
    required this.data,
    required this.dateTime,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) {
    return AccountInfoResponse(
      message: json['message'],
      data: AccountInfo.fromJson(json['data']),
      dateTime: json['dateTime'],
    );
  }
}

class AccountInfo {
  final String accountNumber;
  final String accountName;
  final String bankName;

  AccountInfo({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      accountNumber: json['account_number'],
      accountName: json['account_name'],
      bankName: json['bankName'],
    );
  }
}
