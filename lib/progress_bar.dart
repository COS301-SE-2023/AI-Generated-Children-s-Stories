//wiget

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


/*const Stack(children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 30,
                        //change width of cliprect
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 254, 141, 41)),
                          ),
                        ),
                      ),
                    ),

                    //center the
                    Center(
                      child: Text(
                        "50%",
                        style: TextStyle(
                            //rgb(0, 197, 61)
                            color: Color.fromARGB(255, 84, 34, 9),
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            fontFamily: 'NotoSerif'),
                      ),
                    ),
                  ]),

*/