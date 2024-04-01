import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, bool show) {
  if (show) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  } else {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
