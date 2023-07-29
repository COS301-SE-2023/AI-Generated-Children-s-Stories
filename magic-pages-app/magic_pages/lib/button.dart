import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';

/// This class represents a reusable button
/// The button can navigate to a general route
/// or to a story page
/// If it navigates to a story page, it passes the id of the story
/// to the inside story page

class Button extends StatelessWidget {
  final String text;
  final String route;

  //if it has an id, it means it is a book
  //you pass the id to the inside story page
  //if it does not have an id, it means it is a button
  //with a normal route
  final int? id;

  // ignore: use_key_in_widget_constructors
  const Button({required this.text, required this.route, this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(text),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (id != null) {
              //inside a story page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsideStory(id: id!),
                ),
              );
            } else {
              Navigator.pushNamed(context, route);
            }
          },
          child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 48),
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
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFDFDFD),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
