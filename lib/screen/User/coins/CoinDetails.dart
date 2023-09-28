import 'dart:convert';

import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';

class CoinDetailScreen extends StatefulWidget {
  final String coinName;
  final double coinPrice;
  final String coinImage;

  CoinDetailScreen({
    required this.coinName,
    required this.coinPrice,
    required this.coinImage,
  });

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  final String walletId =
      "eyyfhke8chjnd84835434r3rdd4433r43r443343bkkdkcdcserfd";
  double amount = 0.0;
  var divider = Divider();
  void copyWalletIdToClipboard() {
    //  FlutterClipboard.copy(walletId).then((value) {
    //   // Show a snackbar or toast to indicate that the wallet ID is copied
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Wallet ID copied to clipboard'),
    //     ),
    //   );
    // });
  }

  void _buycoin(var coin, double amount) async {
    try {
      print(coin);
      print(amount);

      final String? saveToken = await APIService().getStoredToken();
      print(saveToken);
      final response = await APIService().tradeCoin(saveToken!, coin, amount);
      print(response.statusCode);
      final Map<String, dynamic> data = json.decode(response.body);
      final dynamic api = data["data"];
      print(api);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName + " Coin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Image.asset(
                "images/coins/usdt.jpeg",
              ),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Row(
                children: [
                  Image.network(
                    widget.coinImage,
                    fit: BoxFit.contain,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  Text('Buy ${widget.coinName}'),
                ],
              ),
            ),
            divider,
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Wallet ID: $walletId'),
              onTap: () {
                // Add logic to copy the wallet ID to the clipboard
                // You can use the clipboard package for this.
              },
            ),
            divider,
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Price: \$${widget.coinPrice.toStringAsFixed(2)}'),
            ),
            divider,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _buycoin(widget.coinName, amount);
                print('Buying ${widget.coinName} with $amount');
              },
              child: Text('Buy ${widget.coinName}'),
            ),
          ],
        ),
      ),
    );
  }
}
