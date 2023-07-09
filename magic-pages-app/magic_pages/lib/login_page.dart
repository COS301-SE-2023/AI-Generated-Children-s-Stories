// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

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
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: 20),
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
                              left:  MediaQuery.of(context).size.width * 0.05, bottom: 0, right: 0, top: 10),
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
                          left: MediaQuery.of(context).size.width * 0.05, bottom: 0, right: 0, top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child:
                            //text
                            Column(
                          children: [
                            //text with background color

                            //add a spacer box
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            //responsive image

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Image.asset(
                                    'assets/images/google-button.png'),
                              ),
                            ),

                            //fixed spacer box
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.1,
                                  left: 20,
                                  right: 20),
                              child: const Text(
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
