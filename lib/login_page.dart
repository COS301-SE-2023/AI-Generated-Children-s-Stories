// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 243, 233),
        body: SafeArea(
          child: Column(
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
              const SizedBox(height: 80),
              //row with image
              Row(
                  //text box that takes up 80% of the screen widht
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
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
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 0, right: 0, top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset('assets/images/MascotWinking.png'),
                      ),
                    ),
                  ]),
              // buttons to log in with apple and google
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, bottom: 0, right: 0, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child:
                        //text
                        Column(
                      children: [
                        //text with background color

                        //add a spacer box
                        const SizedBox(height: 150),
                        //responsive image

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child:
                                Image.asset('assets/images/google-button.png'),
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
                            child:
                                Image.asset('assets/images/apple-button.png'),
                          ),
                        ),

                        //text
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 150, left: 20, right: 20),
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
        ));
  }
}
