import 'package:flutter/material.dart';
import 'package:magic_pages/end_of_story_change_notifier.dart';
import 'package:magic_pages/get_stories_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Wave_Widget.dart';
import 'heart_animation_widget.dart';
import 'inside_story.dart';
import 'navbar.dart';

class EndOfStory extends StatefulWidget {
  final int storyId;

  const EndOfStory({super.key, required this.storyId});

  @override
  State<EndOfStory> createState() => _EndOfStoryState();
}

class _EndOfStoryState extends State<EndOfStory> {
  bool isHeartAnimating = false;
  bool isLiked = false;
  bool isHomePressed = false;
  bool isAgainPressed = false;
  late double screenHeight = MediaQuery.of(context).size.height;

  //make a call to the api to get the story info
  final EndOfStoryChangeNotifier _endOfStoryChangeNotifier =
  EndOfStoryChangeNotifier(GetStoriesService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              const WaveHeaderWidget(),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(32, 50,16,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/MascotWinking.png'),
                          width: 55,
                        ),
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Did you like this book?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                        HeartToggle(),
                      ],
                    ),
                  ),
                  const Expanded(
                      child: SizedBox(width: 0,)
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: GestureDetector(
                      onTapUp: (val){
                        setState(() {
                          isAgainPressed = false;
                        });
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => InsideStory(
                            storyId: widget.storyId,
                            pageId: 0,
                          ),
                        ));
                      },
                      onTapDown: (val){
                        setState(() {
                          isAgainPressed = true;
                        });
                      },
                      onTapCancel: (){
                        setState(() {
                          isAgainPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        height: 50,
                        margin: isAgainPressed ? const EdgeInsets.fromLTRB(0, 6, 0, 0) : const EdgeInsets.fromLTRB(0, 0, 0, 6),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFDFDFD),
                            borderRadius: BorderRadius.circular (25),
                            border: Border.all(
                              color: const Color(0xFFD3D3D3),
                              width: 2,
                            ),
                            boxShadow: isAgainPressed ? null : [
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
                            'READ AGAIN',
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
                  ),
                ],
              ),
              Positioned(
                right: 200,
                bottom: MediaQuery.of(context).size.height*0.325,
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.fromLTRB(32, 50, 16, 0),
                  child: const Text(
                    'Well done, you finished the book!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width-32,
                bottom: MediaQuery.of(context).size.height*0.275-40,
                left: 16,
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, screenHeight*0.3, 16, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD3D3D3),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: LinearPercentIndicator(
                    animateFromLastPercent: true,
                    padding: const EdgeInsets.all(0),
                    barRadius: const Radius.circular(25),
                    backgroundColor: const Color(0xFFFFFFFF),
                    animation: true,
                    lineHeight: 50.0,
                    animationDuration: 1000,
                    percent: 1/1,
                    center: const Text(
                      '100%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF542209),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Poppins'
                      ),
                    ),
                    progressColor: const Color(0xFFFE8D29),
                  ),
                ),
              ),
              Positioned(
                right: 32,
                bottom: MediaQuery.of(context).size.height*0.275,
                child: const Image(
                  image: AssetImage('assets/images/fox.png'),
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 3),
    );
  }

  Widget HeartToggle() {
    Image image;
    if (isLiked == true) {
      image =  const Image(image: AssetImage('assets/images/heart.png'), width: 50);
    } else {
      image =  const Image(image: AssetImage('assets/images/heart-outline.png'), width: 50);
    }

    return HeartAnimationWidget(
      alwaysAnimate: true,
      isAnimating: isLiked,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
              if (isLiked == true) {
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