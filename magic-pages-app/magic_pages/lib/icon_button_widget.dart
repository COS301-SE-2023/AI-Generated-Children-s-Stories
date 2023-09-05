import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconButtonWidget extends StatefulWidget {
  final String message;
  final String? destination;
  final String image;
  final double imageSize;

  const IconButtonWidget( {
    super.key,
    required this.message,
    this.destination,
    required this.image,
    required this.imageSize
  });

  @override
  State<IconButtonWidget> createState() => _IconButtonWidget();
}

class _IconButtonWidget extends State<IconButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val){
        setState(() {
          isPressed = false;
        });
        if (widget.destination != null) {
          Navigator.pushNamed(context, widget.destination!);
        }
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
            color: const Color(0xFFFDFDFD),
            borderRadius: BorderRadius.circular (25),
            border: Border.all(
              color: const Color(0xFFD3D3D3),
              width: 2,
            ),
            boxShadow: isPressed ? null : [
              const BoxShadow(
                color: Color(0xFFD3D3D3),
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0,6),
              )
            ]
        ),
        duration: const Duration(milliseconds: 75),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(widget.image),
                width: widget.imageSize,
              ),
              const SizedBox(width: 8),
              Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFE8D29),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}