import 'package:flutter/material.dart';

/// This class represents the progress bar widget.
/// It is used to show the user how far they are through the book.
/// It is used on the home page and the inside a story page.
/// It takes in the current page and the total pages.
/// It displays the current page as a percentage.
/// It displays the progress bar as a linear progress indicator.
/// It displays the percentage in the middle of the progress bar.
/// The progress bar is displayed at the top of the screen.

class ProgressBar extends StatefulWidget {
  const ProgressBar(
      {super.key, required this.totalPages, required this.currentPages});

  final int currentPages;
  final int totalPages;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD3D3D3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          width: double.infinity,
          height: 35,
          margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: LinearProgressIndicator(
              value: widget.currentPages / widget.totalPages,
              backgroundColor: Color(0xFFFFFFFF),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFE8D29)),
            ),
          ),
        ),
        Text(
          '${(widget.currentPages / widget.totalPages * 100).round()}%',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF542209),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Poppins'
          ),
        ),
      ],
    );
    
    
    
    // Stack(children: <Widget>[
    //   SizedBox(
    //     width: MediaQuery.of(context).size.width,
    //     height: 30,
    //     //change width of cliprect
    //     child: Padding(
    //       padding: EdgeInsets.only(
    //           left: MediaQuery.of(context).size.width * 0.07,
    //           right: MediaQuery.of(context).size.width * 0.07),

    //       //give it a border of grey

    //       child: Container(
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: const Color.fromARGB(211, 211, 211, 255),
    //             width: 2.5,
    //           ),
    //           borderRadius: BorderRadius.circular(15),
    //         ),
    //         child: ClipRRect(
    //           borderRadius: const BorderRadius.all(Radius.circular(15)),
    //           child: LinearProgressIndicator(
    //             value: widget.currentPages / widget.totalPages,
    //             backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    //             valueColor: const AlwaysStoppedAnimation<Color>(
    //                 Color.fromARGB(255, 254, 141, 41)),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),

    //   //center the
    //   Positioned(
    //     left: MediaQuery.of(context).size.width * 0.44,
    //     top: 1,
    //     child: Text(
    //       "${(widget.currentPages / widget.totalPages * 100).round()}%",
    //       style: const TextStyle(
    //           //rgb(0, 197, 61)
    //           color: Color.fromARGB(255, 84, 34, 9),
    //           fontWeight: FontWeight.w500,
    //           fontSize: 16,
    //           fontFamily: 'Poppins'),
    //     ),
    //   ),
    // ]
  }
}
