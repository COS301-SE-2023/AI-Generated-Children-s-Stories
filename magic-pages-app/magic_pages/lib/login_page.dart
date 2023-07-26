//for flutter
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

//for logging in
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_pages/home.dart';
import 'package:magic_pages/global_variables.dart';

class LoginPage extends StatelessWidget {
  Future<bool> sendTokenToBackend(String? token, context) async {
    String tokenToSend = "";

    if (token != null) {
      tokenToSend = token.toString();
    }

    //final url = Uri.parse("http://${GlobalVariables.ipAddress}/authenticate");
    final url = Uri.parse("http://${GlobalVariables.ipAddress}/authenticate");

    //todo: get started and log in should do different things

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

          print("token: ");
          print(checkToken);
          print(checkId);


          if (checkToken == null || checkId == null) {
            return false;
          }
          return true;
        }
      } else {
        String message =
            'Error logging in, response code: ${response.statusCode}';
        if (context.mounted) {
          GlobalVariables.showSnackbarMessage(message, context);
        }
        return false;
      }
    } catch (e) {
      String message = 'Error logging in, message: $e';
      GlobalVariables.showSnackbarMessage(message, context);
      return false;
    }
    return false;
  }

  Future<bool> signInWithGoogle(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

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

        print("Getting token...");

        bool success = await sendTokenToBackend(token, context);

        return success;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          if (context.mounted) {
            GlobalVariables.showSnackbarMessage(
                'The account already exists with a different credential',
                context);
          }
        } else if (e.code == 'invalid-credential') {
          if (context.mounted) {
            GlobalVariables.showSnackbarMessage(
                'Error occurred while accessing credentials. Try again.',
                context);
          }
        } else {
          if (context.mounted) {
            GlobalVariables.showSnackbarMessage('Error $e', context);
          }
        }
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            WaveWidget(
              config: CustomConfig(
                colors: [
                  const Color(0xFF84370F),
                  const Color(0xFFFE8D29),
                  const Color(0xFFFFF3E9),
                ],
                durations: [
                  16000,
                  18000,
                  22000,
                ],
                heightPercentages: [
                  -0.08,
                  -0.07,
                  -0.0525,
                ],
              ),
              size: const Size(double.infinity, double.infinity),
              waveAmplitude: 0,
            ),
            Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/splash');
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(2, 52, 0, 0),
                        padding: const EdgeInsets.all(16),
                        child: const Image(
                          image: AssetImage('assets/images/back-button.png'),
                          width: 24,
                        ),
                      ),
                    ),
                    Column(children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 62, 17, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 54, 19, 0),
                              width: 137,
                              child: const Text(
                                'Ask a grown up to help you',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            const Image(
                              image:
                                  AssetImage('assets/images/MascotWinking.png'),
                              width: 144,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            (186 +
                                MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).padding.bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                bool success = await signInWithGoogle(context);
                                if (success) {
                                  Navigator.pushNamed(context, "/home");
                                } else {
                                  print("Error when singing in...");
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 20),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFDFDFD),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Color(0xFFD3D3D3),
                                      width: 2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD3D3D3),
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(0, 6),
                                      )
                                    ]),
                                child: const Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/google-logo.png'),
                                          width: 25,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'LOGIN WITH GOOGLE',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFE8D29),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                print("sign in with apple...");
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFDFDFD),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Color(0xFFD3D3D3),
                                      width: 2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD3D3D3),
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(0, 6),
                                      )
                                    ]),
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/apple-logo.png'),
                                        width: 25,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'LOGIN WITH APPLE',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFE8D29),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
