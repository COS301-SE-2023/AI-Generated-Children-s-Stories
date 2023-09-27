import 'package:flutter/material.dart';
import 'globals.dart';
import 'heart_animation_widget.dart';
import 'rounded-image.dart';
import 'trailer.dart';

// ignore: must_be_immutable
class BookWidget extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  bool isLiked;
  void Function(BuildContext) updateBookItems;

  // ignore: use_key_in_widget_constructors
  BookWidget( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages,
    required this.isLiked,
    required this.updateBookItems
  });

  @override
  State<BookWidget> createState() => _BookWidget();
}

class _BookWidget extends State<BookWidget> {
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        //initially calls push to add to the route
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => TrailerPage(
            title: widget.title,
            imagePath: widget.imagePath,
            id: widget.id,
            currentPage: widget.currentPage,
            totalPages: widget.totalPages,
            isLiked: widget.isLiked
          ),
        ))

          //when context is popped, this function is called
          //when you press back button
        .then((value) => {
          widget.updateBookItems.call(context)
        });
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RoundedImage(size: 200, url: widget.imagePath, relative: false),
                  Opacity(
                    opacity: isHeartAnimating ? 1 : 0,
                    child: HeartAnimationWidget(
                      isAnimating: isHeartAnimating,
                      duration: const Duration(milliseconds: 700),
                      child: const Image(
                          image: AssetImage('assets/images/heart.png'),
                          width: 80
                      ),
                      onEnd: () {
                        setState(() {
                          isHeartAnimating = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              onDoubleTap: () {
                setState(() {
                  isHeartAnimating = true;
                  widget.isLiked = true;
                });
                Globals.likeStory(true, widget.id, context);
              },
            ),
          ),
          Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,2,10,2),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF542209),
                        fontFamily: 'NotoSerif',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }
}