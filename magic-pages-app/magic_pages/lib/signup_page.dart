import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'global_variables.dart';
import 'icon_button_widget.dart';
import 'wave_widget.dart';

import 'package:http/http.dart' as http;


class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  Future<bool> sendTokenToBackend(String? token, context) async {
    String tokenToSend = "";

    if (token != null) {
      tokenToSend = token.toString();
    }

    final url = Uri.parse("http://${GlobalVariables.ipAddress}/authenticate");

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
          child: Stack(
            children: [
              const WaveHeaderWidget(),
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
                      Column(
                        children: [
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
                                  image: AssetImage('assets/images/mascot-winking.png'),
                                  width: 144,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height-(306+MediaQuery.of(context).padding.top+MediaQuery.of(context).padding.bottom),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque, // Allow outer GestureDetector to receive the tap event
                                      onTap: () async {
                                        print("tap outer");
                                        bool success = await signInWithGoogle(
                                            context);
                                        if (success) {
                                          print("Success!!!!");
                                          if (context.mounted) {
                                            Navigator.pushNamed(context, "/home");
                                          }
                                        }
                                      },
                                      child: const IconButtonWidget(
                                        message: 'GET STARTED WITH GOOGLE',
                                        destination: 'invalid',
                                        image: 'assets/images/google-logo.png',
                                        imageSize: 25
                                      ),
                                    ),
                                  ),


                                Platform.isIOS ? const IconButtonWidget(
                                  message: 'GET STARTED WITH APPLE',
                                  destination: '/home',
                                  image: 'assets/images/apple-logo.png',
                                  imageSize: 25,
                                ) : const SizedBox(height: 0,),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 212,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'By continuing, you agree to our ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and Conditions ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            backgroundColor: Color(0xFFFFF3E9),
                                            title: Text(
                                              'Terms and Conditions', 
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            content: Text(
                                              '...', 
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                  ),
                                  const TextSpan(
                                    text: 'and ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialog(
                                            backgroundColor: Color(0xFFFFF3E9),
                                            title: Text(
                                              'Privacy Policy', 
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            content: Text(
                                              '...', 
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
