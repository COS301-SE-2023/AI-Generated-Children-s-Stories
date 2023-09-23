import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'button_widget.dart';
import 'rounded-image.dart';

/// This class represents...

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  final bool ifSnapScroll;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages,
    required this.ifSnapScroll,
  });

  @override
  State<BookWithProgress> createState() => _BookWithProgressState();
}

class _BookWithProgressState extends State<BookWithProgress> {
  @override
  Widget build(BuildContext context) {
    return widget.ifSnapScroll ? SizedBox(
      height: MediaQuery.of(context).size.height-(94+137),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: RoundedImage(size: 300, url: 'https://media.discordapp.net/attachments/1109207920551416000/1135767659384950984/fullstackfox_The_main_character_Ben_is_a_little_boy_who_has_a_b_fa066e6f-c121-49a1-a5bf-67ca908ef34f.png?width=657&height=657'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: 300,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                color: Color(0xFF542209),
                fontFamily: 'NotoSerif'
              ),
            ),
          ),
    //Add to backend ****************************************************************************************************************************
          widget.currentPage != 0 ? Container(
            margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD3D3D3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              barRadius: const Radius.circular(20),
              backgroundColor: const Color(0xFFFFFFFF),
              animation: true,
              lineHeight: 35.0,
              animationDuration: 1000,
              percent: widget.currentPage / widget.totalPages,
              center: Text(
                '${(widget.currentPage / widget.totalPages * 100).round()}%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF542209),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Poppins'
                ),
              ),
              progressColor: const Color(0xFFFE8D29),
            ),
          ) : const SizedBox(),
    //
          Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            margin: const EdgeInsets.only(top: 16),
            child: ButtonWidget(
              message: 'VIEW',
              destination: '/insideStory',
              storyId: widget.id,
              pageId: widget.currentPage,
            )
          ),
        ]
      ),
    ) :
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: RoundedImage(size: 300, url: 'https://media.discordapp.net/attachments/1109207920551416000/1135767659384950984/fullstackfox_The_main_character_Ben_is_a_little_boy_who_has_a_b_fa066e6f-c121-49a1-a5bf-67ca908ef34f.png?width=657&height=657'),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: 300,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              color: Color(0xFF542209),
              fontFamily: 'NotoSerif'
            ),
          ),
        ),
    //Add to backend ****************************************************************************************************************************
        widget.currentPage != 0 ? Container(
          margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD3D3D3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            barRadius: const Radius.circular(20),
            backgroundColor: const Color(0xFFFFFFFF),
            animation: true,
            lineHeight: 35.0,
            animationDuration: 1000,
            percent: widget.currentPage / widget.totalPages,
            center: Text(
              '${(widget.currentPage / widget.totalPages * 100).round()}%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF542209),
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'Poppins'
              ),
            ),
            progressColor: const Color(0xFFFE8D29),
          ),
        ) : const SizedBox(),
    //
        Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          margin: const EdgeInsets.only(top: 16),
          child: ButtonWidget(
            message: 'VIEW',
            destination: '/insideStory',
            storyId: widget.id,
            pageId: widget.currentPage,
          )
        ),
      ]
    );
  }
}
