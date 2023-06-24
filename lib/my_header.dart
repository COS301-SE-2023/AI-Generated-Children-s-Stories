import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  const MyHeader({super.key, required this.message});

  final String message;

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/Wave.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      Row(children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Transform.rotate(
            angle: -0.2,
            child: Image.asset(
              'assets/images/MascotWinking.png',
              width: MediaQuery.of(context).size.width * 0.15,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600),
          ),
        ),
        Stack(children: [
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/images/Profile.png',
              width: MediaQuery.of(context).size.width * 0.2,
            ),
          )),
        ])
      ]),
    ]);
  }
}
