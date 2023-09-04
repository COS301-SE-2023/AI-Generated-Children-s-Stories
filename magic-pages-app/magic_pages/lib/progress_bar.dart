import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
      {super.key, required this.totalPages, required this.currentPage});

  final int currentPage;
  final int totalPages;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD3D3D3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          barRadius: const Radius.circular(20),
          backgroundColor: const Color(0xFFFFFFFF),
          animation: true,
          lineHeight: 35.0,
          animationDuration: 1000,
          percent: widget.currentPage / widget.totalPages,
          center: Text(
            '${(widget.currentPage / widget.totalPages * 100).round()}%',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFF542209),
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'Poppins'),
          ),
          progressColor: const Color(0xFFFE8D29),
        ));
  }
}
