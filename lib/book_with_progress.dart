import 'package:flutter/material.dart';
import 'progress_bar.dart';
import 'image_button.dart';

/// This class represents...

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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            children: [
              //story cover
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 25.0),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ]),
              //story title
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 27,
                          //rgb(84, 34, 9)
                          color: Color.fromARGB(255, 84, 34, 9),
                          fontFamily: 'NotoSerif'),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                      child: ProgressBar(
                    currentPages: widget.currentPage,
                    totalPages: widget.totalPages,
                  ))
                ],
              ),
              Row(
                children: [
                  //image button
                  ImageButton(
                    imagePath: 'assets/images/viewButton.png',
                    route: '/insideAStory/${widget.id}',
                  )
                ],
              )
            ],
          ),
        ));
  }
}
