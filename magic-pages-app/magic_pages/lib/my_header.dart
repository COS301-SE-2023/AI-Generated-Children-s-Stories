import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHeader extends StatefulWidget {
  const MyHeader({super.key, required this.message});

  final String message;

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

/// This class represents the header of the home page.
/// It contains the UI for the header of the home page.
/// The UI contains a mascot, a message, and a profile picture.
/// The mascot is a winking fox.
/// The message tells the user if they are reading a new book or continuing to read the book they were reading.
/// The profile picture is a picture of the user.

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      margin: const EdgeInsets.only(top: 50.0),
      child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.message != 'Logout' ? Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Transform.rotate(
                        angle: -0.2,
                        child: const Image(
                          image: AssetImage('assets/images/mascot-winking.png'),
                          width: 48,
                        ),
                      ),
                    ),
                  ) : const SizedBox(),
                  widget.message != 'Logout' ? Expanded(
                    flex: widget.message != 'Logout' ? 3 : 2,
                    child: Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF542209),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ) : const SizedBox(),
                  widget.message != 'Logout' ? Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: widget.message == 'Logout' ? const Image(
                            image: AssetImage('assets/images/nav-icons/signout.webp'),
                            width: 40,
                          ) : const Image(
                            image: AssetImage('assets/images/nav-icons/signout-outline.webp'),
                            width: 40,
                          ),
                        ),
                    ),
                  )
                  : Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: () async {
                                if (!await launchUrl(Uri.parse('https://fullstackfox.co.za/help'))) {
                                  throw Exception('Could not launch help page');
                                }
                              },
                            child: Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFDFDFD),
                                  borderRadius: BorderRadius.circular (25),
                                  border: Border.all(
                                    color: const Color(0xFFD3D3D3),
                                    width: 2,
                                  ),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/images/nav-icons/help.webp'),
                                      width: 25,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'HELP',
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
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: const Image(
                              image: AssetImage('assets/images/nav-icons/signout.webp'),
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
    );
  }
}