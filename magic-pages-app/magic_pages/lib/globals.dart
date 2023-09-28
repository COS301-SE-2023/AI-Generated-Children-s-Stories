import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Globals {
  //make sure you copy ipv4 wireless lan

  static String ipAddress = "13.247.19.241:8080";

  static void showSnackbarMessage(String message, context) {
    var mySnackbar = SnackBar(content: Text(message));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
    }
  }

  static Future<bool> likeStory(bool mustLike, int bookId, context) async {
    List<String> idToken = await Globals.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];

    try {
      final url = Uri.parse(
          "http://${Globals.ipAddress}/liked/stories");

      final Map<String, dynamic> data = {
        "userId": id,
        "storyId": bookId.toString(),
        "apiKey": token
      };

      http.Response response;

      if (mustLike) {
        response = await http.post(
          url,
          body: data,
        );
      } else {
        response = await http.delete(
          url,
          body: data,
        );
      }

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        // Globals.showSnackbarMessage(
        //     "Error from post: ${response.body}", context);
        return false;
      }
    } catch (e) {
      // print("Error: $e");
    }

    return true;
  }

  static Future<List<String>> getIdAndToken() async {
    const storage = FlutterSecureStorage();
    String? id = await storage.read(key: 'id');
    String? token = await storage.read(key: 'api_token');

    if (id == null || token == null)
      print("error");

    List<String> list = [];
    if (id != null) list.add(id);
    if (token != null) list.add(token);

    return list;
  }
}
