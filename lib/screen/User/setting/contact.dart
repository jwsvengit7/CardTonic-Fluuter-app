import 'dart:convert';

import 'package:cardmonix/dto/response/AccountInfoResponse.dart';
import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  final UserData userDetails;
  const Contact({super.key, required this.userDetails});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String accountName = '';
  String accountNumber = '';
  String bankName = '';
  @override
  void initState() {
    super.initState();
    _fetchAccount();
  }

  Future<void> _fetchAccount() async {
    try {
      var token = await APIService().getStoredToken();
      final response =
          await APIService().get_account(token, widget.userDetails.id);

      print(widget.userDetails.id);
      print(token);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final AccountInfoResponse accountInfo =
            AccountInfoResponse.fromJson(data);
        setState(() {
          accountName = accountInfo.data.accountName;
          accountNumber = accountInfo.data.accountNumber;
          bankName = accountInfo.data.bankName;
        });
      } else {
        print("Failed to fetch account. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred while fetching account: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildContactInfoCard(
            "Name",
            widget.userDetails.user_name ?? "N/A",
          ),
          buildContactInfoCard(
            "Email",
            widget.userDetails.email ?? "N/A",
          ),
          buildContactInfoCard(
            "Phone",
            widget.userDetails.phone ?? "N/A",
          ),
          buildAccountDetailsCard(
            "Account Details",
            "Account ID: 123456789",
            "Member since: January 2022",
          ),
        ],
      ),
    );
  }

  Widget buildContactInfoCard(String title, String content) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(content),
      ),
    );
  }

  Widget buildAccountDetailsCard(
      String title, String accountID, String memberSince) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
          ),
          ListTile(
            title: const Text("Bank Name",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              bankName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Account Name",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              accountName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text("Account Number",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            subtitle: Text(
              accountNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
