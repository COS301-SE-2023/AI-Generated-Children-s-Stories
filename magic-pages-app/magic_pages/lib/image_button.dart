import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';

/// This class represents an image button.
/// It is used whenever a button and an image needs to be displayed
/// It can route to any page

class ImageButton extends StatefulWidget {
  final String imagePath;
  final String route;

  //if it has an id, it means it is a book
  //you pass the id to the inside story page
  //if it does not have an id, it means it is a button
  //with a normal route
  final int? id;

  // ignore: use_key_in_widget_constructors
  const ImageButton({required this.imagePath, required this.route, this.id});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: IconButton(
            icon: Image.asset(widget.imagePath),
            iconSize: 50,
            onPressed: () {
              //if it has an id, it means it is a book
              //otherwise it's a normal route
              if (widget.id == null) {
                Navigator.pushNamed(context, widget.route);
              } else {
                //pass the id to the inside story page
                //so it can get the correct story
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InsideStory(id: widget.id)),
                );
              }
            },
          ),
        ),
      ],
    ));
  }
}
