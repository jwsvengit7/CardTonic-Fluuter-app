import 'package:cardmonix/screen/Login_Signup.dart';
import 'package:cardmonix/service/api_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Otp extends StatefulWidget {
  final String email;

  const Otp({super.key, required this.email});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP")),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 150,
            alignment: Alignment.center,
            child: Image.asset(
              'images/logo-app.jpeg',
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Enter the OTP sent to ${widget.email}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          _buildOtpInputFields(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 117, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Verify OTP",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resendOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 127, 225),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Resend OTP",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildOtpDigitField(_otpController1),
        _buildOtpDigitField(_otpController2),
        _buildOtpDigitField(_otpController3),
        _buildOtpDigitField(_otpController4),
      ],
    );
  }

  Widget _buildOtpDigitField(TextEditingController controller) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(229, 239, 236, 236),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 60,
        width: 64,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.headlineMedium,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
        ),
      ),
    );
  }

  void _verifyOtp() async {
    String otp = _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text;

    print("Entered OTP: $otp");
    try {
      final response =
          await APIService().verifyOtp(email: widget.email, otp: otp);
      final Map<String, dynamic> responseData = json.decode(response.body);
      final dynamic successMessage = responseData['data'];
      print(successMessage);
      if (response.statusCode == 200) {
        _showSuccessDialog(context, successMessage);
      } else if (response.statusCode == 201) {
        _showMessageWarning(context, successMessage);
      }
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
          content: const Text('Account Have been Confirm'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
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
          title: const Text('OTP Error'),
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

  void _resendOtp() {
    // Implement logic to resend OTP here.
  }

  @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    super.dispose();
  }
}
