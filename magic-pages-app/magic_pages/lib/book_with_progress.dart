import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/button_widget.dart';
import 'package:magic_pages/inside_story.dart';
import 'package:magic_pages/progress_bar.dart';
import 'rounded-image.dart';
import 'package:magic_pages/trailer.dart';

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  final bool isLiked;
  final bool ifSnapScroll;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress(
      {required this.title,
        required this.imagePath,
        required this.id,
        required this.currentPage,
        required this.totalPages,
        required this.isLiked,
        required this.ifSnapScroll,
      });

  @override
  State<BookWithProgress> createState() => _BookWithProgressState();
}

class _BookWithProgressState extends State<BookWithProgress> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return widget.ifSnapScroll ?
    Container(
        margin: const EdgeInsets.only(bottom: 0),
        height: MediaQuery.of(context).size.height-(94+138+35+MediaQuery.of(context).padding.top+MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RoundedImage(size: 0.35, url: widget.imagePath, relative: true),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: AutoSizeText(
                  widget.title,
                  maxFontSize: double.infinity,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 52,
                    color: Color(0xFF542209),
                    fontFamily: 'NotoSerif',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            widget.currentPage != 0 ? ProgressBar(totalPages: widget.totalPages, currentPage: widget.currentPage) : const SizedBox(),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              margin: const EdgeInsets.only(top: 16),
              child: GestureDetector(
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
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
            ),
          ]
        ),
      ) :
      SizedBox(
        height: MediaQuery.of(context).size.height-(94+138+MediaQuery.of(context).padding.top+MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RoundedImage(size: 0.35, url: widget.imagePath, relative: true),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                child: AutoSizeText(
                  widget.title,
                  maxFontSize: double.infinity,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 52,
                    color: Color(0xFF542209),
                    fontFamily: 'NotoSerif',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            widget.currentPage != 0 ? ProgressBar(totalPages: widget.totalPages, currentPage: widget.currentPage) : const SizedBox(),
            Container(
              margin: const EdgeInsets.fromLTRB(0,16,0,16),
              child: GestureDetector(
                onTapUp: (val) {
                  setState(() {
                    isPressed = false;
                  });
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
                onTapDown: (val) {
                  setState(() {
                    isPressed = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressed = false;
                  });
                },
                child: AnimatedContainer(
                  height: 50,
                  width: double.infinity,
                  margin: isPressed ? const EdgeInsets.fromLTRB(16, 6, 16, 0) : const EdgeInsets.fromLTRB(16, 0, 16, 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE8D29),
                    borderRadius: BorderRadius.circular (25),
                    boxShadow: isPressed ? null : [
                      const BoxShadow(
                        color: Color(0xFF84370F),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0,6),
                      )
                    ]
                  ),
                  duration: const Duration(milliseconds: 75),
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
            ),
          ]),
      );
  }
}