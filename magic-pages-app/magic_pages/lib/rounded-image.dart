import 'package:flutter/material.dart';

class RoundedImage extends StatefulWidget {
  final String url;
  final double size;
  final bool relative;

  const RoundedImage({
    super.key, required this.size, required this.url, required this.relative,
  });

  @override
  State<RoundedImage> createState() => _RoundedImageState();
}

class _RoundedImageState extends State<RoundedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.relative ? widget.size*MediaQuery.of(context).size.height : widget.size,
      height: widget.relative ? widget.size*MediaQuery.of(context).size.height : widget.size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(widget.url),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}