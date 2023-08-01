import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Wave_Widget.dart';
import 'button_widget.dart';
import 'heart_animation_widget.dart';
import 'inside_story.dart';
import 'navbar.dart';

/// This class represents...

class TrailerPage extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  bool isLiked;

  // ignore: use_key_in_widget_constructors
  TrailerPage( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages,
    required this.isLiked
  });

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  bool isHeartAnimating = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              const WaveHeaderWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 52.0),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            padding: const EdgeInsets.all(16),
                            child: const Image(
                              image: AssetImage('assets/images/back-button.png'),
                              width: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Image(
                                          image: AssetImage('assets/images/MascotWinking.png'),
                                          width: 50,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 12),
                                          child: const Text(
                                            'Like this book?',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              overflow: TextOverflow.clip,
                                              fontSize: 18,
                                              color: Color(0xFF542209),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: HeartToggle()
                                    ),
                                  ],
                                ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(64, 32, 64, 16),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  widget.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
                            child: AutoSizeText(
                              widget.title,
                              maxFontSize: double.infinity,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 64,
                                color: Color(0xFF542209),
                                fontFamily: 'NotoSerif',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  widget.currentPage == 0
                  ? Container(
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: ButtonWidget(
                      message: 'READ NOW',
                      destination: '/insideStory',
                      storyId: widget.id,
                      pageId: widget.currentPage,
                    )
                  )
                  : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(80, 0, 80, 0),
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
                          lineHeight: 30.0,
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ButtonWidget(
                          message: 'KEEP READING',
                          destination: '/insideStory',
                          storyId: widget.id,
                          pageId: widget.currentPage,
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: GestureDetector(
                          onTapUp: (val){
                            setState(() {
                              isPressed = false;
                            });
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => InsideStory(
                                storyId: widget.id,
                                pageId: 0,
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
                            child: const Center(
                              child: Text(
                                'START AGAIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFE8D29),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]
              ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 3),
    );
  }

  Widget HeartToggle() {
    Image image;
    if (widget.isLiked == true) {
      image =  const Image(image: AssetImage('assets/images/heart.png'), width: 30);
    } else {
      image =  const Image(image: AssetImage('assets/images/heartOutline.png'), width: 30);
    }

    return HeartAnimationWidget(
      alwaysAnimate: true,
      isAnimating: widget.isLiked,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.isLiked = !widget.isLiked;
              if (widget.isLiked == true) {
                isHeartAnimating = true;
              }
            });
          },
          child: image,
        ),
      ),
    );
  }
}
