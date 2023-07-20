// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// This class represents the state of the login page.
/// It contains the UI for the login page.
/// The UI contains a back button, a text box, and two buttons to log in with apple and google.
/// The text box contains a message telling the user to ask a grown up to help them log in.
/// The buttons take the user to the home page.
/// The buttons are images of the google and apple logos.

class _LoginPageState extends State<LoginPage> {
  Future<bool> sendTokenToBackend(String? token, BuildContext myContext) async {
    String tokenToSend = "";

    if (token != null) {
      tokenToSend = token.toString();
    }

    final url = Uri.parse("http://192.168.68.116:8000/authenticate");

    try {
      final response = await http.post(url, body: tokenToSend);
      //check the response code
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data["status"] == "success") {
          //save the API token
          const storage = FlutterSecureStorage();

          await storage.write(key: "api_token", value: data["api_token"]);
          await storage.write(key: "id", value: data["id"].toString());

          String? checkToken = await storage.read(key: 'api_token');
          String? checkId = await storage.read(key: 'id');

          if (checkToken == null || checkId == null) {
            return false;
          }
          return true;
        }
      } else {
        String message =
            'Error logging in, response code: ${response.statusCode}';
        var mySnackbar = SnackBar(content: Text(message));

        ScaffoldMessenger.of(myContext).showSnackBar(mySnackbar);
        return false;
      }
    } catch (e) {
      String message = 'Error logging in, message: $e';
      var mySnackbar = SnackBar(content: Text(message));

      ScaffoldMessenger.of(myContext).showSnackBar(mySnackbar);
      return false;
    }
    return false;
  }

  Future<bool> signIn(BuildContext myContext) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    //initilise a google sign in
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        String? token = await userCredential.user?.getIdToken();

        bool success = await sendTokenToBackend(token, myContext);
        return success;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          const mySnakbar = SnackBar(
              content: Text(
                  'The account already exists with a different credential'));

          ScaffoldMessenger.of(myContext).showSnackBar(mySnakbar);
        } else if (e.code == 'invalid-credential') {
          const mySnakbar = SnackBar(content: Text('Invalid credentials'));

          ScaffoldMessenger.of(myContext).showSnackBar(mySnakbar);
        } else {
          var mySnakbar = SnackBar(content: Text('Error ' + e.toString()));
          ScaffoldMessenger.of(myContext).showSnackBar(mySnakbar);
        }
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 243, 233),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 0, right: 0, top: 10),
                        child: IconButton(
                          //icon image
                          icon: Image.asset('assets/images/back-button.png'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  //add a spacer
                  const SizedBox(height: 60),

                  //row with image
                  Row(
                      //text box that takes up 80% of the screen width
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child:
                                //text
                                const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Ask a grown up to help you log in.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              bottom: 0,
                              right: 0,
                              top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:
                                Image.asset('assets/images/MascotWinking.png'),
                          ),
                        ),
                      ]),
                  // buttons to log in with apple and google
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          bottom: 0,
                          right: 0,
                          top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child:
                            //text
                            Column(
                          children: [
                            //text with background color

                            //add a spacer box
                            const SizedBox(height: 20),
                            //responsive image

                            GestureDetector(
                              key: const Key('GoogleLogin'),
                              onTap: () async {
                                bool success = await signIn(context);

                                if (success) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Home(), // Navigate to the Home Page
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Image.asset(
                                    'assets/images/google-button.png'),
                              ),
                            ),

                            const SizedBox(height: 5),

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Image.asset(
                                    'assets/images/apple-button.png'),
                              ),
                            ),

                            //text
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Text(
                                'By logging in, you agree to our Terms of Service and Privacy Policy.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ],
          ),
        )));
  }
}
