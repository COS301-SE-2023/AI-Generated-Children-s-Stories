import 'dart:math';
import 'package:Magic_Pages/progress_bar.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

class InsideStory extends StatefulWidget {
  InsideStory({super.key});

  List<String> messages = ["Well done!", "Almost there!", "Way to go!"];

  List<String> storyText = [
    "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
    "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unloc, ked, but he was determined to find out.",
    "Carrying the key, Andy went on an exciting journey through tall grass, up branches, and across a tiny stream. Finally, he discovered a huge rock with door.",
    "Andy turned the key in the keyhole, and the door opened, revealing a hidden chamber. Inside, there was delicious food."
  ];

  List<String> images = [
    "assets/images/stories/AndyTheAnt/img1.jpg",
    "assets/images/stories/AndyTheAnt/img2.jpg",
    "assets/images/stories/AndyTheAnt/img3.jpg",
    "assets/images/stories/AndyTheAnt/img4.jpg"
  ];

  @override
  State<InsideStory> createState() => _InsideStoryState();
}

class _InsideStoryState extends State<InsideStory> {
  int messageIndex = 0;
  int storyIndex = 0;

  void next() {
    if (storyIndex < widget.storyText.length - 1) {
      setState(() {
        messageIndex = Random().nextInt(widget.messages.length);
        storyIndex = storyIndex + 1;
      });
    }
  }

  void prev() {
    if (storyIndex > 0) {
      setState(() {
        messageIndex = Random().nextInt(widget.messages.length);
        storyIndex = storyIndex - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
          child: Column(
        children: [
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
                  widget.messages[messageIndex],
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 20, right: 10, bottom: 0),
                    child: Text(
                        textAlign: TextAlign.center,
                        widget.storyText[storyIndex],
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 58, 23, 6),
                          fontSize:
                              (1 - MediaQuery.sizeOf(context).aspectRatio) * 30,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: 20,
                top: 15,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => {prev()},
                  child: Image.asset('assets/images/back.png'),
                ),
                const Spacer(),
                Image.asset('assets/images/pause.png'),
                const Spacer(),
                GestureDetector(
                    onTap: () => {next()},
                    child: Image.asset('assets/images/forward.png')),
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}

class PageState extends ChangeNotifier {}

/*

bottomNavigationBar: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 15, left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () => {
                        prev()
                      },
                      child: Image.asset(
                        'assets/images/back.png'
                      ),
                    ),
                     
                    Spacer(),
                    Image.asset(
                      'assets/images/pause.png'
                    ),
                    Spacer(), 
          
                    GestureDetector(
                      onTap: () => {
                        next()
                      },
                      child: Image.asset(
                        'assets/images/forward.png'
                      )
                    )
                    ,
                  ],),
                )
              ],
            ), 
            Row(
              children: [
                NavbarWidget()
              ],
            )
        ],
      )

*/