import 'package:flutter/material.dart';
import 'heart_animation_widget.dart';
import 'trailer.dart';

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
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => InsideStory(
        //     storyId: widget.id,
        //     pageId: widget.currentPage,
        //   ),
        // ));
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => TrailerPage(
            title: widget.title,
            imagePath: widget.imagePath,
            id: widget.id,
            currentPage: widget.currentPage,
            totalPages: widget.totalPages,
            isLiked: widget.isLiked,
          ),
        ));

      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
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

  Widget HeartToggle() {
    Image image;
    if (widget.isLiked == true) {
      image =  const Image(image: AssetImage('assets/images/heart.png'), width: 32);
    } else {
      image =  const Image(image: AssetImage('assets/images/heart-outline.png'), width: 32);
    }

    return HeartAnimationWidget(
      alwaysAnimate: true,
      isAnimating: widget.isLiked,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.isLiked = !widget.isLiked;
              if (widget.isLiked == true) {
                isHeartAnimating = true;
              }
            });
          },
          child: image,
        ),
      ),
    );
  }
// Widget HeartToggle() {
//     IconData icon;
//     Color color = const Color(0xFF542209);
//     if (widget.isLiked == true) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_outline;
//     }

//     return HeartAnimationWidget(
//       alwaysAnimate: true,
//       isAnimating: widget.isLiked,
//       child: IconButton(
//         icon: Icon(icon, color: color, size: 32),
//         onPressed: () => setState(() {
//           widget.isLiked = !widget.isLiked;
//           if (widget.isLiked == true) {
//             isHeartAnimating = true;
//           }
//         }),
//       ),
//     );
//   }
}