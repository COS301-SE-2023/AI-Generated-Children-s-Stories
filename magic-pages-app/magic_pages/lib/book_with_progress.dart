import 'package:flutter/material.dart';
import 'package:magic_pages/trailer.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'button_widget.dart';

/// This class represents...

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  final bool isLiked;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages,
    required this.isLiked
  });

  @override
  State<BookWithProgress> createState() => _BookWithProgressState();
}

class _BookWithProgressState extends State<BookWithProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Image.network(
              widget.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: 300,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 32,
                  color: Color(0xFF542209),
                  fontFamily: 'NotoSerif'
              ),
            ),
          ),
          Container(
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
                    fontFamily: 'Poppins'
                ),
              ),
              progressColor: const Color(0xFFFE8D29),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 16),
              child: TrailerPage(
                currentPage: widget.currentPage,
                isLiked: widget.isLiked,
                totalPages: widget.totalPages,
                title: widget.title,
                imagePath: widget.imagePath,
                id: widget.id
              )
          ),
        ]
    );
  }
}
