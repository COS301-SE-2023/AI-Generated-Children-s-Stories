import 'dart:math';
import 'progress_bar.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

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
  final int? id;

  InsideStory({super.key, required this.id});

  //messages displayed by the mascott
  final List<String> messages = ["Well done!", "Almost there!", "Way to go!"];
  //halfway message when the user is halfway through the story
  final String halfWayMessage = "Halfway there!";

  //story text is the content of the story
  final List<String> storyText = [
    "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
    "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unloc, ked, but he was determined to find out.",
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
  int messageIndex = 0;
  int storyIndex = 0;
  bool shownHalfway = false;

  /// This function updates the story index and message index.
  /// It also updates the halfway message.
  /// It is called when the user presses the next button.
  void next() {
    if (storyIndex < widget.storyText.length - 1) {
      setState(() {
        messageIndex = Random().nextInt(widget.messages.length);
        storyIndex += 1;
      });
    } else {
      //route to the end of story page with the name in
      //pass the name in the constructor of the story page
      //when you press the next button on the last page
      //TODO: write a unit test to check this
    }

    if (storyIndex == (widget.storyText.length) / 2) {
      setState(() {
        shownHalfway = true;
      });
    } else {
      setState(() {
        shownHalfway = false;
      });
    }
  }

  /// This function updates the story index and message index.
  /// It is called when the user presses the previous button.
  /// It does not update the halfway message.
  void prev() {
    if (storyIndex > 0) {
      setState(() {
        messageIndex = Random().nextInt(widget.messages.length);
        storyIndex -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 243, 233),
        body: SafeArea(
            child: Column(
          children: [
            //header image
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Wave.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //heart and halfway message
            Row(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Image.asset(
                  'assets/images/heart-empty.png',
                  width: MediaQuery.of(context).size.width * 0.12,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    textDirection: TextDirection.ltr,
                    shownHalfway
                        ? "Halfway there!"
                        : widget.messages[messageIndex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Stack(children: [
                Positioned(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    'assets/images/MascotWinking.png',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                )),
              ])
            ]),
            Row(
              children: [
                Center(
                  child: ProgressBar(
                      totalPages: widget.storyText.length - 1,
                      currentPages: storyIndex),
                )
              ],
            ),

            //story image
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  //image
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              widget.images[storyIndex],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //story text at the bottom of the image
            Expanded(
              child: Column(
                //center align
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 20, right: 10, bottom: 0),
                      child: Text(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          widget.storyText[storyIndex],
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 58, 23, 6),
                            fontSize:
                                (1 - MediaQuery.sizeOf(context).aspectRatio) *
                                    30,
                          ))),
                ],
              ),
            ),

            //control bar to navigate through the story
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20,
                  top: 15,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  GestureDetector(
                    key: const Key('previousButton'),
                    onTap: () => {prev()},
                    child: Image.asset('assets/images/back.png'),
                  ),
                  const Spacer(),
                  Image.asset('assets/images/pause.png'),
                  const Spacer(),
                  GestureDetector(
                      key: const Key('nextButton'),
                      onTap: () => {
                            // if (storyIndex == widget.storyText.length - 1)
                            //   {
                            //     //TODO: write a unit test to check this
                            //     //go to the liked page if the story is finished
                            //     Navigator.pushNamed(context, '/endBook')
                            //   }
                            // else
                            next() //go to the next page
                          },
                      child: Image.asset('assets/images/forward.png')),
                ],
              ),
            )
          ],
        )),
        bottomNavigationBar: const NavbarWidget(),
      ),
    );
  }
}
