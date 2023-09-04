import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';
import 'package:magic_pages/story_page.dart';

//todo: make a parent button
//two children: navigate to route
//navigate to inside story page

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  final String message;
  final String? destination;
  final int? storyId;
  final bool? isEnabled;
  final List<StoryPage>? pages;
  final int? currentPage;
  final bool? isLiked;

  //for story...

  const ButtonWidget({
    super.key,
    required this.message,
    this.destination,
    this.isEnabled,
    this.storyId,
    this.pages,
    this.currentPage,
    this.isLiked
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidget();
}

class _ButtonWidget extends State<ButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val) {
//loading
        if (widget.isEnabled != null && widget.isEnabled == false) {
          return;
        }

        setState(() {
          isPressed = false;
        });

        print(widget.storyId);
        print(widget.currentPage);
        print(widget.pages);

        widget.storyId == null
            ? Navigator.pushNamed(context, widget.destination ?? widget.destination!)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InsideStory(
                        storyId: widget.storyId!,
                        currentPage: widget.currentPage!,
                        pages: widget.pages!,
                        isLiked: widget.isLiked!,
                      )
                ));
      },
      onTapDown: (val) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        height: 50,
        width: double.infinity,
        margin: isPressed
            ? const EdgeInsets.fromLTRB(16, 6, 16, 0)
            : const EdgeInsets.fromLTRB(16, 0, 16, 6),
        decoration: BoxDecoration(
            color: (widget.isEnabled != null && widget.isEnabled == false)
                ? const Color(0xFFABABAB)
                : const Color(0xFFFE8D29),
            borderRadius: BorderRadius.circular(25),
            boxShadow: isPressed
                ? null
                : [
                    BoxShadow(
                      color: (widget.isEnabled != null &&
                              widget.isEnabled == false)
                          ? const Color(0xFF595959)
                          : const Color(0xFF84370F), //Color(0xFF84370F),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 6),
                    )
                  ]),
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
