import 'package:flutter/material.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Transform.rotate(
                        angle: -0.2,
                        child: const Image(
                          image: AssetImage('assets/images/MascotWinking.png'),
                          width: 48,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
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
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image(
                            image: AssetImage('assets/images/Profile.png'),
                            width: 40,
                          ),
                        ),
                    ),
                  ),
                ]
            ),
          ),
    );
  }
}









    // Column(children: [
    //   Row(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 8.0),
    //         child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.width * 0.1,
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               fit: BoxFit.fill,
    //               image: AssetImage('assets/images/Wave.png'),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   Row(children: [
    //     Expanded(
    //       flex: 1,
    //       child: Transform.rotate(
    //         angle: -0.2,
    //         child: Padding(
    //           padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.01),
    //           child: Image.asset(
    //             'assets/images/MascotWinking.png',
    //             width: MediaQuery.of(context).size.width * 0.04,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       flex: 3,
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 15),
    //         child: Text(
    //           widget.message,
    //           textAlign: TextAlign.center,
    //           style: const TextStyle(
    //               fontSize: 25,
    //               color: Color.fromARGB(255, 0, 0, 0),
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //         flex: 1,
    //         child: Padding(
    //           padding: const EdgeInsets.only(right: 5),
    //           child: IconButton(
    //             icon: Image.asset('assets/images/Profile.png'),
    //             iconSize: 50,
    //             onPressed: () {
    //               Navigator.pushNamed(context, '/profile');
    //             },
    //           ),
    //         )),
    //   ])
    // ]);