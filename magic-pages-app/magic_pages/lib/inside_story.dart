import 'dart:math';
import 'package:magic_pages/end_of_story.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'heart_animation_widget.dart';
import 'package:flutter/material.dart';

/// This class represents the state of the inside story page.
/// It keeps track of the current story index, the current message index, and whether the halfway message has been shown.
/// It also contains the next and previous functions, which update the story index and message index.
/// The next and previous functions are called when the user presses the next and previous buttons.
/// The next and previous functions also update the halfway message.
/// The halfway message is shown when the user is halfway through the story.
/// The halfway message is randomly selected from a list of messages.

class InsideStory extends StatefulWidget {
  //for routing to the book with progress page
  //instantiate the inside story page with the id of the story
  //this allows it to call the api to get the story
  final int storyId;
  final int pageId;

  InsideStory({
    super.key, 
    required this.storyId,
    required this.pageId  
  });

  //messages displayed by the mascott
  final List<String> messages = ["Well done!", "Almost there!", "Way to go!", "Keep going!", "Doing great!"];
  final String firstMessage = "Let's read together!";
  final String halfwayMessage = "Half way there!";
  final String lastMessage = "The last page!";
  

  //story text is the content of the story
  final List<String> storyText = [
    "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
    "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unlock, ked, but he was determined to find out.",
    "Carrying the key, Andy went on an exciting journey through tall grass, up branches, and across a tiny stream. Finally, he discovered a huge rock with door.",
    "Andy turned the key in the keyhole, and the door opened, revealing a hidden chamber. Inside, there was delicious food."
  ];

  //story images
  final List<String> images = [
    "assets/images/stories/AndyTheAnt/img1.jpg",
    "assets/images/stories/AndyTheAnt/img2.jpg",
    "assets/images/stories/AndyTheAnt/img3.jpg",
    "assets/images/stories/AndyTheAnt/img4.jpg"
  ];

  @override
  State<InsideStory> createState() => InsideStoryState();
}

class InsideStoryState extends State<InsideStory> {
  late int storyIndex = widget.pageId;
  bool isHeartAnimating = false;
  bool isLiked = false;
  bool isBackPressed = false;
  bool isNextPressed = false;
  bool isHomePressed = false;
  late int randomMessageIndex = Random().nextInt(widget.messages.length-1);

  /// This function updates the story index and message index.
  /// It also updates the halfway message.
  /// It is called when the user presses the next button.
  void next() {
    if (storyIndex < widget.storyText.length - 1) {
      setState(() {
        storyIndex += 1;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => EndOfStory(
          storyId: widget.storyId,
        ),
      ));
    }
  }

  /// This function updates the story index and message index.
  /// It is called when the user presses the previous button.
  /// It does not update the halfway message.
  void prev() {
    if (storyIndex > 0) {
      setState(() {
        storyIndex -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //heart and halfway message
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: HeartToggle()
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width-(16+24+110+108),
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          storyIndex == 0 
                          ? widget.firstMessage
                          : storyIndex == widget.storyText.length - 1
                          ? widget.lastMessage
                          : storyIndex == (widget.storyText.length) / 2
                          ? widget.halfwayMessage
                          : widget.messages[randomMessageIndex], 
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 18,
                            color: Color(0xFF542209),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(24, 0, 16, 0),
                        child:  Transform.rotate(
                          angle: 0.125,
                          child: const Image(
                            image: AssetImage('assets/images/Mascot.png'),
                            width: 110,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD3D3D3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: LinearPercentIndicator(
                  animateFromLastPercent: true,
                  padding: const EdgeInsets.all(0),
                  barRadius: const Radius.circular(20),
                  backgroundColor: const Color(0xFFFFFFFF),
                  animation: true,
                  lineHeight: 35.0,
                  animationDuration: 1000,
                  percent: storyIndex / (widget.storyText.length),
                  center: Text(
                    '${(storyIndex / (widget.storyText.length) * 100).round()}%',
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
              AspectRatio(
                aspectRatio: 1.25,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    widget.images[storyIndex],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: AutoSizeText(
                    widget.storyText[storyIndex],
                    maxFontSize: double.infinity,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 64,
                      color: Color(0xFF542209),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Opacity(
                        opacity: storyIndex == 0 ? 0.5 : 1,
                        child: storyIndex == 0 
                        ? Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width/2-(16+8),
                            margin: const EdgeInsets.fromLTRB(16, 0, 8, 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDFDFD),
                              borderRadius: BorderRadius.circular (25),
                              border: Border.all(
                                color: const Color(0xFFD3D3D3),
                                width: 2,
                              ),
                              boxShadow: const [
                                 BoxShadow(
                                  color: Color(0xFFD3D3D3),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(0,6),
                                )
                              ]
                            ),
                            child: Center(
                              child: Transform.rotate(
                                angle: 3.13,
                                child: const Image(image: AssetImage('assets/images/arrow-orange.png'), width: 35)
                              ),
                            ),
                          )
                        : GestureDetector(
                          onTapUp: (val){
                            setState(() {
                              isBackPressed = false;
                            });
                            prev();
                          },
                          onTapDown: (val){
                            setState(() {
                              isBackPressed = true;
                            });
                          },
                          onTapCancel: (){
                            setState(() {
                              isBackPressed = false;
                            });
                          },
                          child: AnimatedContainer(
                            height: 50,
                            margin: isBackPressed ? const EdgeInsets.fromLTRB(16, 6, 8, 0) : const EdgeInsets.fromLTRB(16, 0, 8, 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDFDFD),
                              borderRadius: BorderRadius.circular (25),
                              border: Border.all(
                                color: const Color(0xFFD3D3D3),
                                width: 2,
                              ),
                              boxShadow: isBackPressed ? null : [
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
                              child: Transform.rotate(
                                angle: 3.13,
                                child: const Image(image: AssetImage('assets/images/arrow-orange.png'), width: 35)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTapUp: (val){
                          setState(() {
                            isHomePressed = false;
                          });
                          Navigator.pushNamed(context, '/home');
                        },
                        onTapDown: (val){
                          setState(() {
                            isHomePressed = true;
                          });
                        },
                        onTapCancel: (){
                          setState(() {
                          isHomePressed = false;
                          });
                        },
                        child: AnimatedContainer(
                          height: 50,
                          margin: isHomePressed ? const EdgeInsets.fromLTRB(0, 6, 0, 0) : const EdgeInsets.fromLTRB(0, 0, 0, 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDFDFD),
                            borderRadius: BorderRadius.circular (25),
                            border: Border.all(
                              color: const Color(0xFFD3D3D3),
                              width: 2,
                            ),
                            boxShadow: isHomePressed ? null : [
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
                            child: Image(image: AssetImage('assets/images/home.png'), width: 35),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTapUp: (val){
                          setState(() {
                            isNextPressed = false;
                          });
                          next();
                        },
                        onTapDown: (val){
                          setState(() {
                            isNextPressed = true;
                          });
                        },
                        onTapCancel: (){
                          setState(() {
                            isNextPressed = false;
                          });
                        },
                        child: AnimatedContainer(
                          height: 50,
                          margin: isNextPressed ? const EdgeInsets.fromLTRB(8, 6, 16, 0) : const EdgeInsets.fromLTRB(8, 0, 16, 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFE8D29),
                            borderRadius: BorderRadius.circular (25),
                            boxShadow: isNextPressed ? null : [
                              const BoxShadow(
                                color: Color(0xFF84370F),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(0,6),
                              )
                            ]
                          ),
                          duration: const Duration(milliseconds: 75),
                          child: const Center(
                            child: Image(image: AssetImage('assets/images/arrow-white.png'), width: 35),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
          // Row(
          //   children: [
          //     Center(
          //       child: ProgressBar(
          //           totalPages: widget.storyText.length - 1,
          //           currentPages: storyIndex),
          //     )
          //   ],
          // ),
        
          // //story image
          // SizedBox(
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         left: MediaQuery.of(context).size.width * 0.05,
          //         right: MediaQuery.of(context).size.width * 0.05),
          //     child: Row(
          //       //image
          //       children: [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.9,
          //           height: MediaQuery.of(context).size.width * 0.9,
          //           child: Column(
          //             children: [
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(20),
          //                 child: Image.asset(
          //                   widget.images[storyIndex],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        
          // //story text at the bottom of the image
          // Expanded(
          //   child: Column(
          //     //center align
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Padding(
          //           padding: const EdgeInsets.only(
          //               top: 0, left: 20, right: 10, bottom: 0),
          //           child: Text(
          //               textDirection: TextDirection.ltr,
          //               textAlign: TextAlign.center,
          //               widget.storyText[storyIndex],
          //               textScaleFactor: 1.1,
          //               style: TextStyle(
          //                 color: const Color.fromARGB(255, 58, 23, 6),
          //                 fontSize:
          //                     (1 - MediaQuery.sizeOf(context).aspectRatio) *
          //                         30,
          //               ))),
          //     ],
          //   ),
          // ),
        
          // //control bar to navigate through the story
          // Padding(
          //   padding: EdgeInsets.only(
          //       bottom: 20,
          //       top: 15,
          //       left: MediaQuery.of(context).size.width * 0.05,
          //       right: MediaQuery.of(context).size.width * 0.05),
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         key: const Key('previousButton'),
          //         onTap: () => {prev()},
          //         child: Image.asset('assets/images/back.png'),
          //       ),
          //       const Spacer(),
          //       Image.asset('assets/images/pause.png'),
          //       const Spacer(),
          //       GestureDetector(
          //           key: const Key('nextButton'),
          //           onTap: () => {
          //                 if (storyIndex == widget.storyText.length - 1)
          //                   {
          //                     //TODO: write a unit test to check this
          //                     //go to the liked page if the story is finished
          //                     Navigator.pushNamed(context, '/endBook')
          //                   }
          //                 else
          //                   next() //go to the next page
          //               },
          //           child: Image.asset('assets/images/forward.png')),
          //     ],
          //   ),
          // )
                ],
              ),
        ),
      ),
    );
  }

  Widget HeartToggle() {
    Image image;
    if (isLiked == true) {
      image =  const Image(image: AssetImage('assets/images/heart.png'), width: 50);
    } else {
      image =  const Image(image: AssetImage('assets/images/heartOutline.png'), width: 50);
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
