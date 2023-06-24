import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final String imagePath;
  final String route; 

  const ImageButton({required this.imagePath, required this.route});

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, top: MediaQuery.of(context).size.height*0.05),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: IconButton(
              icon: Image.asset(widget.imagePath),
              iconSize: 50,
              onPressed: () {
                Navigator.pushNamed(context, widget.route);
              },
            ),
          ),
        )
      ],) 
    );

  }
}
