import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  SecurityState createState() => SecurityState();
}

class SecurityState extends State<Security> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
      ),
    );
  }
}
