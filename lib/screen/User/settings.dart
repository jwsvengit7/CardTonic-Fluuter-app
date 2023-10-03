import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:cardmonix/screen/User/setting/account.dart';
import 'package:cardmonix/screen/User/setting/contact.dart';
import 'package:cardmonix/screen/User/setting/graph.dart';
import 'package:cardmonix/screen/User/setting/security.dart';
import 'package:cardmonix/screen/User/setting/wallet.dart';
import 'package:cardmonix/screen/User/setting/card.dart';
import 'package:cardmonix/screen/User/setting/password.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Setting extends StatelessWidget {
  Color color = const Color.fromARGB(255, 237, 70, 41);
  UserData userData;

  Setting({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardContent()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Card",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.card_membership),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Graph()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Graph",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.graphic_eq_sharp),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Wallet()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Connect Wallet",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.wallet_giftcard),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Account()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Add Account",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.account_box),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Password()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Passsword",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.password),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Contact(userDetails: userData)),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Contact Information",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.history),
              ],
            ),
          ),
        ),
        Container(
          width: 90,
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Security()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Security",
                  style: TextStyle(fontSize: 20, color: color),
                ),
                const Icon(Icons.security),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
