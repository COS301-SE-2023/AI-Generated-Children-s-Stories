import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';
import 'package:magic_pages/progress_bar.dart';
import 'package:magic_pages/trailer.dart';

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  final bool isLiked;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress(
      {required this.title,
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
              totalPages: widget.totalPages, currentPage: widget.currentPage),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  TrailerPage(
                    title: widget.title,
                    imagePath: widget.imagePath,
                    id: widget.id,
                    currentPage: widget.currentPage,
                    totalPages: widget.totalPages,
                    isLiked: widget.isLiked)
                ));
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