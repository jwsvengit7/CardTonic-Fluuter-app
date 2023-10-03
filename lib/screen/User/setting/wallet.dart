import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  WalletState createState() => WalletState();
}

class WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
    );
  }
}
