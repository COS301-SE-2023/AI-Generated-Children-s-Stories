import 'package:flutter/material.dart';
import 'package:magic_pages/progress_bar.dart';

/// This class represents

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress(
      {required this.title,
      required this.imagePath,
      required this.id,
      required this.currentPage,
      required this.totalPages});

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
              key: const Key('StoryCover'),
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
                  fontFamily: 'NotoSerif'),
            ),
          ),
          ProgressBar(
              totalPages: widget.totalPages, currentPages: widget.currentPage),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/insideAStory',
                  arguments: widget.id);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                  color: const Color(0xFFFE8D29),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF84370F),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 6),
                    )
                  ]),
              child: const Center(
                child: Text(
                  'VIEW',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFDFDFD),
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
