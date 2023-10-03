class WalletResponse {
  final int walletId;
  final double walletAmount;
  final double walletInUsd;
  final String coin;

  WalletResponse({
    required this.walletId,
    required this.walletAmount,
    required this.walletInUsd,
    required this.coin,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      walletId: json['walletId'] as int,
      walletAmount: json['wallet_amount'] as double,
      walletInUsd: json['walletInUsd'] as double,
      coin: json['coin'] as String,
    );
  }
}
