import 'package:flutter/material.dart';
import 'heart_animation_widget.dart';

// ignore: must_be_immutable
class BookWidget extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  bool isLiked;

  // ignore: use_key_in_widget_constructors
  BookWidget( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages,
    required this.isLiked
  });

  @override
  State<BookWidget> createState() => _BookWidget();
}

class _BookWidget extends State<BookWidget> {
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
                Opacity(
                  opacity: isHeartAnimating ? 1 : 0,
                  child: HeartAnimationWidget(
                    isAnimating: isHeartAnimating,
                    duration: const Duration(milliseconds: 700),
                    child: const Icon(
                      Icons.favorite, 
                      color: Color(0xFF542209), 
                      size: 90,
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
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: HeartToggle(),
              ),
            ),
          ]
        )
      ],
    );
  }

  Widget HeartToggle() {
      IconData icon;
      Color color = const Color(0xFF542209);
      if (widget.isLiked == true) {
        icon = Icons.favorite;
      } else {
        icon = Icons.favorite_outline;
      }

      return HeartAnimationWidget(
        alwaysAnimate: true,
        isAnimating: widget.isLiked,
        child: IconButton(
          icon: Icon(icon, color: color, size: 32),
          onPressed: () => setState(() {
            widget.isLiked = !widget.isLiked;
            if (widget.isLiked == true) {
              isHeartAnimating = true;
            }
          }),
        ),
      );
    }
}