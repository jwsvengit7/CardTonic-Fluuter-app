import 'dart:convert';
import 'package:cardmonix/dto/response/Bank.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final banks = <Bank>[];
  Bank? selectedBank;
  String accountName = '';
  bool isFetchingAccountName = false;
  bool isSaveButtonDisabled = true;

  final accountNumberController = TextEditingController();
  SizedBox sizedBox = const SizedBox(height: 20);

  @override
  void initState() {
    super.initState();
    fetchBanks();
  }

  void fetchBanks() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.paystack.co/bank'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final bankData = data['data'];

        setState(() {
          banks.addAll(bankData.map<Bank>((bankJson) {
            return Bank(
              name: bankJson['name'],
              code: bankJson['code'],
            );
          }));
        });
      } else {
        print('Failed to fetch banks');
      }
    } catch (e) {
      print(e);
    }
  }

  void _saveAccount() async {
    try {
      isFetchingAccountName = true;
      final token = await APIService().getStoredToken();
      print(token);

      final response = await APIService().saveAccount(token!,
          accountNumberController.text, selectedBank!.name, accountName);
      isFetchingAccountName = false;
      final Map<String, dynamic> api = json.decode(response.body);
      final dynamic data = api["data"];
      if (response.statusCode == 409) {
        _popup(response.statusCode, data["message"]);
        return;
      }
      _popup(response.statusCode, data);
    } catch (e) {
      _popup(400, "Try again");
      print(e);
    }
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bank Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox,
                Image.asset("images/account.png"),
                sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: DropdownButtonFormField<Bank>(
                        value: selectedBank,
                        decoration: const InputDecoration(
                          labelText: 'Select a bank',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: banks.map((bank) {
                          return DropdownMenuItem<Bank>(
                            value: bank,
                            child: SizedBox(
                              width: 300,
                              child: Text(bank.name),
                            ),
                          );
                        }).toList(),
                        onChanged: (Bank? value) {
                          setState(() {
                            selectedBank = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                sizedBox,
                TextFormField(
                  controller: accountNumberController,
                  onChanged: onAccountNumberChanged,
                  decoration: const InputDecoration(
                    labelText: 'Account Number',
                    border: OutlineInputBorder(),
                    hintText: 'Enter account number',
                  ),
                ),
                sizedBox,
                Container(
                  child: _load(isFetchingAccountName, accountName),
                ),
                sizedBox,
                buildSaveButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _load(bool isFetchingAccountName, String accountName) {
    if (isFetchingAccountName) {
      return const CircularProgressIndicator();
    } else if (accountName.isNotEmpty) {
      return Text(
        "Account Name: $accountName",
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  void onAccountNumberChanged(String value) {
    setState(() {
      accountName = '';
      isFetchingAccountName = false;
      isSaveButtonDisabled = true;
    });

    if (value.length == 10) {
      fetchAccountName(value);
    }
  }

  Future<void> fetchAccountName(String accountNumber) async {
    if (selectedBank == null) {
      return;
    }

    final bankCode = selectedBank!.code;

    try {
      setState(() {
        isFetchingAccountName = true;
      });

      final response =
          await APIService().getAccountName(accountNumber, bankCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final accountNameResponse = data['data']['account_name'] ?? 'NOT FOUND';

        setState(() {
          accountName = accountNameResponse;
          isFetchingAccountName = false;
          isSaveButtonDisabled = false;
        });
      } else {
        setState(() {
          accountName = 'NOT FOUND';
          isFetchingAccountName = false;
          isSaveButtonDisabled = true;
        });
        print("Failed to fetch account name");
      }
    } catch (e) {
      setState(() {
        isFetchingAccountName = false;
        isSaveButtonDisabled = true;
      });
      print(e);
    }
  }

  Widget buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isSaveButtonDisabled ? null : _saveAccount,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSaveButtonDisabled ? Colors.grey : Colors.blue,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          'Save Changes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _popup(var statusCode, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
