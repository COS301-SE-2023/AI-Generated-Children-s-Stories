import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
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
                size: Size(MediaQuery.of(context).size.width, 1000),
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
                                    height: 50,
                                    width: double.infinity,
                                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFDFDFD),
                                      borderRadius: BorderRadius.circular (25),
                                      border: Border.all(
                                        color: Color(0xFFD3D3D3),
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xFFD3D3D3),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0,6),
                                        )
                                      ]
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage('assets/images/google-logo.png'),
                                            width: 25,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'GET STARTED WITH GOOGLE',
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
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFDFDFD),
                                      borderRadius: BorderRadius.circular (25),
                                      border: Border.all(
                                        color: Color(0xFFD3D3D3),
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xFFD3D3D3),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0,6),
                                        )
                                      ]
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage('assets/images/apple-logo.png'),
                                            width: 25,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'GET STARTED WITH APPLE',
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
