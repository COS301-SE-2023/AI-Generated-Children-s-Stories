import 'package:flutter/material.dart';
import 'heart_animation_widget.dart';
import 'globals.dart';

class HeartToggle extends StatefulWidget {
  bool isLiked;
  int id;

  HeartToggle({super.key, required this.isLiked, required this.id});

  @override
  State<StatefulWidget> createState() => _HeartToggleWidget();
}

class _HeartToggleWidget extends State<HeartToggle> {
  bool isHeartAnimating = false;
  late Image image = widget.isLiked ? const Image(image: AssetImage('assets/images/heart.png'), width: 32) : const Image(image: AssetImage('assets/images/heart-outline.png'), width: 32);

  void likeUnlike() async {
    widget.isLiked = !widget.isLiked;
    ToggleHeart();
    bool success = await Globals.likeStory(widget.isLiked, widget.id, context);

    //failed, revert the changes
    if (!success) {
      widget.isLiked = !widget.isLiked;
      ToggleHeart();
    }
  }

  void ToggleHeart() {
    print(widget.isLiked);
    if (widget.isLiked == true) {
      image = const Image(
          image: AssetImage('assets/images/heart.png'),
          width: 32);
      isHeartAnimating = true;
    } else {
      image = const Image(
          image: AssetImage('assets/images/heart-outline.png'), width: 32);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return HeartAnimationWidget(
        alwaysAnimate: true,
        isAnimating: widget.isLiked,
        child: Container(
            padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
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

