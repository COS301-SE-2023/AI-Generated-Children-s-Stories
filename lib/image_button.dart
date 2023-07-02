import 'package:flutter/material.dart';

/// This class represents an image button.
/// It is used whenever a button and an image needs to be displayed
/// It can route to any page

class ImageButton extends StatefulWidget {
  final String imagePath;
  final String route;

  // ignore: use_key_in_widget_constructors
  const ImageButton({required this.imagePath, required this.route});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: IconButton(
              icon: Image.asset(widget.imagePath),
              iconSize: 50,
              onPressed: () {
                Navigator.pushNamed(context, widget.route);
              },
            ),
          ),
        )
      ],
    ));
  }
}
