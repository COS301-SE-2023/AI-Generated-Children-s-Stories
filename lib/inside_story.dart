import 'dart:math';
import 'package:Magic_Pages/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myHeader.dart';

class InsideStory extends StatefulWidget {
  InsideStory({
    super.key
  });

  List<String> messages = [
    "Well done!", 
    "Almost there!",
    "Way to go!"
  ];

  List<String> storyText = [
    "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends every day.", 
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
    setState(() {
      messageIndex = Random().nextInt(widget.messages.length);
      storyIndex = storyIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageState(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 243, 233),
        body: SafeArea(
          //back button
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                    Row(children: [
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
                    ],),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                          child: Image.asset(
                                'assets/images/heart-empty.png',
                                width: MediaQuery.of(context).size.width*0.12,
                              ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: 
                              Text(
                              widget.messages[messageIndex],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5), 
                                child:  Image.asset(
                                  'assets/images/MascotWinking.png',
                                  width:  MediaQuery.of(context).size.width*0.2,
                                ),
                              )
                            ),
                          ]
                        )
                        
                      ]
                    ),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5), 
                        child: ProgressBar(totalPages: widget.storyText.length - 1, currentPages: storyIndex)
                      )
                      
                    ],)
                  ])]
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  //image
                  children: [
                      SizedBox(
                      width: MediaQuery.of(context).size.width,
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
              Row(children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { 
                    next();
                  },
                  child: Text('TextButton'),
                )
                
              ],), 
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                child: Row(children: [
                  Image.asset(
                    'assets/images/back.png'
                  ), 
                  Spacer(),
                  Image.asset(
                    'assets/images/pause.png'
                  ),
                  Spacer(), 
                  Image.asset(
                    'assets/images/forward.png'
                  ),
                ],),
              )
            ]
          )
        )
      )
    );
  }
}

class PageState extends ChangeNotifier {

}