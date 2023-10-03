import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart' as AnimatedButtonPackage;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

Widget modarsuccess(BuildContext context) {
  return Center(
    child: Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          AnimatedButtonPackage.AnimatedButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "Warning",
                desc: "This is it",
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
            },
            child: Text("Button Text"),
          ),
        ],
      ),
    ),
  );
}
