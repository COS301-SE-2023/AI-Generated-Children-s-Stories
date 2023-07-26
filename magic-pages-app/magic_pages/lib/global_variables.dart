import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalVariables {
  static String ipAddress = "196.249.9.241:8000";

  static void showSnackbarMessage(String message, context) {
    var mySnackbar = SnackBar(content: Text(message));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
    }
  }

  static Future<List<String>> getIdAndToken() async {
    const storage = FlutterSecureStorage();
    String? id = await storage.read(key: 'id');
    String? token = await storage.read(key: 'api_token');

    print("id from storage: ");
    print(id);

    print("token from storage: ");
    print(token);

    List<String> list = List.empty();
    if (id != null)
      list.add(id);
    if (token != null)
      list.add(token);

    return list;
  }
}
