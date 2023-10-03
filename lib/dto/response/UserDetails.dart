class UserDetails {
  final String message;
  final UserData data;
  final int dateTime;

  UserDetails({
    required this.message,
    required this.data,
    required this.dateTime,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      message: json['message'],
      data: UserData.fromJson(json['data']),
      dateTime: json['dateTime'],
    );
  }
}

class Balance {
  final BigInt amount;
  final BigInt? balanceId;
  final String? currency;

  Balance({
    required this.amount,
    required this.balanceId,
    required this.currency,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    final double amountDouble = json['amount'] as double;
    final BigInt amount = BigInt.from(amountDouble);

    return Balance(
      amount: amount,
      balanceId: json['balanceId'] == null
          ? null
          : BigInt.tryParse(json['balanceId'].toString()),
      currency: json['currency'],
    );
  }

  @override
  String toString() {
    return 'Balance(amount: $amount, balanceId: $balanceId, currency: $currency)';
  }
}

class UserData {
  final int? id;
  final String? email;
  final String? user_name;
  final String? phone;
  final String? dob;
  final String? profile;
  final String? role;
  final Balance? balance;

  UserData({
     this.id,
     this.email,
     this.user_name,
     this.phone,
     this.dob,
     this.profile,
     this.role,
     this.balance,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      user_name: json['user_name'],
      phone: json['phone'],
      dob: json['dob'],
      profile: json['profile'],
      role: json['role'],
      balance: Balance.fromJson(json['balance']),
    );
  }
}
