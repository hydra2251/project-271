import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showalert(
    BuildContext context, String errormessage, AlertType type) async {
  await Alert(
    context: context,
    title: errormessage,
    type: type,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  ).show();
}
