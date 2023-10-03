import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> {
  SizedBox spaceHieigt = const SizedBox(height: 20);

  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  SizedBox sizedBox = const SizedBox(height: 20);

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox,
                Image.asset("images/password.png"),
                sizedBox,
                buildInputField("Old Password"),
                spaceHieigt,
                spaceHieigt,
                buildInputField("New Password"),
                spaceHieigt,
                spaceHieigt,
                buildInputField("Re Enter New Password"),
                spaceHieigt,
                _buildElevatedButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
          hintText: text,
        ),
      ),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 244, 117, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        child: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
