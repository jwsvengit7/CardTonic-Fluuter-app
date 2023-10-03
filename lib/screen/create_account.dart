import 'package:cardmonix/screen/Verification/otp_verification.dart';
import 'package:cardmonix/screen/login_signup.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  SizedBox spaceHieigt = const SizedBox(height: 20);

  // final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    if (_passwordController.text != _cpasswordController.text) {
      _showMessageWarning(context, "Password does not Match");
    }
    try {
      final response = await APIService().createAccount(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text);

      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic successMessage = responseData['data'];
      print(successMessage);
      _showSuccessDialog(context, successMessage);
    } catch (e) {
      print(e);
      _showMessageWarning(context, "Error occurred");
    }
  }

  void _showSuccessDialog(BuildContext context, var successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(successMessage),
          content: const Text('Otp Have been sent to your inbox'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Otp(email: _emailController.text)),
                );
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showMessageWarning(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration'),
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

  void _showResponseAlert(BuildContext context, http.Response response) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    String title = response.statusCode == 201 ? 'Success' : 'Error';
    String message = responseBody['data'];
    print(response.statusCode);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                if (response.statusCode == 201) {
                  _showSuccessDialog(context, message);
                } else {
                  _showSuccessDialog(context, message);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _wrightContent(String text, String text2) {
    return SizedBox(
      width: 250,
      child: Center(
        child: Column(children: [
          Text(text),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.to(const LoginSignupScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 117, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Container(
              width: 100,
              height: 40,
              alignment: Alignment.center,
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: 400,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 650,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  children: [
                    spaceHieigt,
                    Image.asset(
                      'images/logo-app.jpeg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    spaceHieigt,
                    buildInputField(
                      hintText: 'Username',
                      controller: _usernameController,
                    ),
                    spaceHieigt,
                    buildInputField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    spaceHieigt,
                    buildInputField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    spaceHieigt,
                    buildInputField(
                      hintText: 'Re-Password',
                      controller: _cpasswordController,
                      obscureText: true,
                    ),
                    spaceHieigt,
                    buildElevatedButton(context),
                    spaceHieigt,
                    _wrightContent("Already have an account", "Log In"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField({
    required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }

  Widget buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _registerUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const SizedBox(
        width: 280,
        height: 50,
        child: Center(
          child: Text(
            'Signup',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
