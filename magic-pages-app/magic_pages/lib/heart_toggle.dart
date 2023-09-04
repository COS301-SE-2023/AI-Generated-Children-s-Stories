import 'package:flutter/material.dart';
import 'heart_animation_widget.dart';
import 'globals.dart';

class HeartToggle extends StatefulWidget {
  bool isLiked;
  int id;

  HeartToggle({required this.isLiked, required this.id});

  @override
  State<StatefulWidget> createState() => _HeartToggleWidget();
}

class _HeartToggleWidget extends State<HeartToggle> {
  bool isHeartAnimating = false;
  Image image =
  const Image(image: AssetImage('assets/images/heart.png'), width: 32);

  void likeUnlike() async {
    widget.isLiked = !widget.isLiked;
    if (widget.isLiked == true) {
      image = const Image(
          image: AssetImage('assets/images/heart-outline.png'),
          width: 32);
      isHeartAnimating = true;
    } else {
      image = const Image(
          image: AssetImage('assets/images/heart.png'), width: 32);
    }
    bool success = await Globals.likeStory(widget.isLiked, widget.id, context);

    //failed, revert the changes
    if (!success) {
      if (widget.isLiked) {
        image =
        const Image(image: AssetImage('assets/images/heart.png'), width: 32);
      } else {
        image =
        const Image(image: AssetImage('assets/images/heart.png'), width: 32);
      }
      widget.isLiked = !widget.isLiked;
      setState(() {});
    }

    //call the global variables file
    setState(() {
      widget.isLiked = !widget.isLiked;
      if (widget.isLiked == true) {
        Globals.likeStory(true, widget.id, context);
        isHeartAnimating = true;
      } else {
        Globals.likeStory(false, widget.id, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HeartAnimationWidget(
        alwaysAnimate: true,
        isAnimating: widget.isLiked,
        child: Container(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
                onTap: () {
                  likeUnlike();
                },
                child: image
            )
        )
    );
  }

}

