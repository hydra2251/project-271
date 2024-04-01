import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showalert(
    BuildContext context, String errormessage, AlertType type) async {
  Alert(
    context: context,
    type: type,
    title: errormessage,
    buttons: [
      DialogButton(
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          // Use the context provided by Alert to pop the dialog
          Navigator.of(context, rootNavigator: true).pop();
        },
        width: 120,
      )
    ],
  ).show();
}
