import 'package:flutter/material.dart';

class GlobalVariables {
  static String ipAddress = "196.249.8.171:8000";

  static void showSnackbarMessage(String message, context) {
    var mySnackbar = SnackBar(content: Text(message));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
    }
  }
}
