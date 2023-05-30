//wiget

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key, 
    required this.totalPages, 
    required this.currentPages
  });

  final int currentPages;
  final int totalPages;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 30,
        //change width of cliprect
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: LinearProgressIndicator(
            value: widget.currentPages/ widget.totalPages,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            valueColor: const AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 254, 141, 41)),
          ),
        ),
      ),
    
      //center the
      Positioned(
        left: MediaQuery.of(context).size.width * 0.44,
        top: 4,
        child: Text(
          "${(widget.currentPages / widget.totalPages * 100).round()}%",
          style: const TextStyle(
              //rgb(0, 197, 61)
              color: Color.fromARGB(255, 84, 34, 9),
              fontWeight: FontWeight.bold,
              fontSize: 19,
              fontFamily: 'NotoSerif'),
        ),
      ),
    ]);
  }
}