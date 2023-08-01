import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  final String message;
  final String destination;
  final int? storyId;
  final int? pageId;
  
  const ButtonWidget( {
    super.key, 
    required this.message,
    required this.destination, 
    this.storyId, 
    this.pageId
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidget();
}

class _ButtonWidget extends State<ButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val){
        setState(() {
          isPressed = false;
        });
        widget.storyId == null
        ? Navigator.pushNamed(context, widget.destination)
        : Navigator.push(context, MaterialPageRoute(
          builder: (context) => InsideStory(
            storyId: widget.storyId!,
            pageId: widget.pageId!,
          ),
        ));
      },
      onTapDown: (val){
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: (){
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        height: 50,
        width: double.infinity,
        margin: isPressed ? const EdgeInsets.fromLTRB(16, 6, 16, 0) : const EdgeInsets.fromLTRB(16, 0, 16, 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFE8D29),
          borderRadius: BorderRadius.circular (25),
          boxShadow: isPressed ? null : [
            const BoxShadow(
              color: Color(0xFF84370F),
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0,6),
            )
          ]
        ),
        duration: const Duration(milliseconds: 75),
        child: Center(
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color(0xFFFDFDFD),
            ),
          ),
        ),
      ),
    );
  }
}