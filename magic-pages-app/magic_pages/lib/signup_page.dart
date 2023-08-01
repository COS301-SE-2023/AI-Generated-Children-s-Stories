import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'icon_button_widget.dart';
import 'wave_widget.dart';


class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                          margin: const EdgeInsets.fromLTRB(8, 52, 0, 0),
                          padding: const EdgeInsets.all(16),
                          child: const Image(
                              image: AssetImage('assets/images/back-button.png'),
                              width: 32,
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
                                  image: AssetImage('assets/images/MascotWinking.png'),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: const IconButtonWidget(
                                      message: 'GET STARTED WITH GOOGLE',
                                      destination: '/home',
                                      image: 'assets/images/google-logo.png',
                                      imageSize: 25,
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
