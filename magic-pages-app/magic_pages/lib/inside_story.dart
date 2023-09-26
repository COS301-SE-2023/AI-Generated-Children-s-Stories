import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:magic_pages/end_of_story.dart';
import 'package:magic_pages/heart_toggle.dart';
import 'package:magic_pages/story_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/globals.dart';
import 'package:http/http.dart' as http;

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
  final int currentPage;
  final bool isLiked;
  final void Function(int) updatePage;
  final void Function(bool) updateLiked;

  InsideStory({
    super.key,
    required this.storyId,
    required this.pages,
    required this.currentPage,
    required this.isLiked,
    required this.updatePage,
    required this.updateLiked
  });

  //messages displayed by the mascot
  final List<String> messages = ["Well done!", "Almost there!", "Way to go!", "Keep going!", "Doing great!"];
  final String firstMessage = "Let's read together!";
  final String halfwayMessage = "Half way there!";
  final String lastMessage = "The last page!";

  //story text is the content of the story
  final List<StoryPage> pages;

  @override
  State<InsideStory> createState() => InsideStoryState();
}

class InsideStoryState extends State<InsideStory> {
  late int storyIndex = widget.currentPage;
  bool isHeartAnimating = false;
  late bool isLiked = widget.isLiked;
  bool isBackPressed = false;
  bool isNextPressed = false;
  bool isHomePressed = false;
  late int randomMessageIndex = Random().nextInt(widget.messages.length-1);

  Completer<void> speakingCompleter = Completer<void>();
  bool ttsSpeaking = false;

  int start = 0;
  int end = 0;

  //tts
  late FlutterTts flutterTts;

  Future<void> speak(String text) async {

    setState(() {
      start = 0;
      end = 0;
    });

    if (!ttsSpeaking) {
      setState(() {
        ttsSpeaking = true;
      });
      await flutterTts.speak(text);
    } else {
      await flutterTts.stop();
      setState(() {
        ttsSpeaking = false;
      });
    }


    flutterTts.setCompletionHandler(() {
      print("done speaking...");
      setState(() {
        ttsSpeaking = false;
      });
    });
  }

  Future<void> updatePageNumber(int pageNumber) async {

    final url = Uri.parse("http://${Globals.ipAddress}/progress");

    List<String> idToken = await Globals.getIdAndToken();

    final Map<String, dynamic> data = {
      "apiKey": idToken[1],
      "userId": idToken[0],
      "storyId": widget.storyId,
      "pageNumber": storyIndex
    };

    http.Response response = await http.post(
        url,
        headers: {
          'content-type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      widget.updatePage(pageNumber);
    } else {
      Globals.showSnackbarMessage("Error: ${response.body}", context);
    }
  }

  @override
  void initState() {
    super.initState();

    flutterTts = FlutterTts();

    flutterTts.setSpeechRate(0.3);

    flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      setState(() {
        start = startOffset;
        end = endOffset;
        ttsSpeaking = true;
      });
      print(start.toString() + " " + end.toString());
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        start = 0;
        end = 0;
        ttsSpeaking = false;
      });
    });

  }

  /// This function updates the story index and message index.
  /// It also updates the halfway message.
  /// It is called when the user presses the next button.
  void next() {
    if (storyIndex < widget.pages.length - 1) {
      setState(() {
        storyIndex += 1;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => EndOfStory(
          storyId: widget.storyId,
          pages: widget.pages,
          isLiked: widget.isLiked,
          updatePage: widget.updatePage,
          updateLiked: widget.updateLiked,
        ),
      ));
    }

    if (storyIndex < widget.pages.length && storyIndex >= 0) {
      updatePageNumber(storyIndex);
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
    updatePageNumber(storyIndex);
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
              Header(context),
              ProgressBar(),

              //image
              AspectRatio(
                aspectRatio: 1.25,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.pages[storyIndex].getImage(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //play button
              GestureDetector(
                onTap: () {
                  speak(widget.pages[storyIndex].text);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ttsSpeaking ? Text("Pause TTS") : Text("Play TTS"),
                ),
              ),

              //text
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: AutoSizeText.rich(
                      maxFontSize: double.infinity,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 64,
                        color: Color(0xFF542209),
                        fontFamily: 'Poppins',
                      ),
                      TextSpan(
                          children: [
                            TextSpan(
                                text: widget.pages[storyIndex].text.substring(0, start)
                            ),
                            TextSpan(
                                text: widget.pages[storyIndex].text.substring(start, end),
                                style: const TextStyle(
                                    color: Color(0xFFFE8D29),
                                    fontWeight: FontWeight.w600
                                )
                            ),
                            TextSpan(
                                text: widget.pages[storyIndex].text.substring(end, widget.pages[storyIndex].text.length)
                            )
                          ]
                      )
                  ),
                ),
              ),
              NavBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Row Header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 16),
            child: HeartToggle(isLiked: isLiked, id: widget.storyId, updateLiked: widget.updateLiked)
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width-(16+24+110+108),
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                storyIndex == 0
                    ? widget.firstMessage
                    : storyIndex == widget.pages.length - 1
                    ? widget.lastMessage
                    : storyIndex == (widget.pages.length) / 2
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
                  image: AssetImage('assets/images/mascot.png'),
                  width: 110,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container NavBar(BuildContext context) {
    return Container(
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
    );
  }

  Container ProgressBar() {
    return Container(
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
        percent: widget.pages.isEmpty ? 0 : storyIndex / (widget.pages.length),
        center: Text(
          '${widget.pages.isEmpty ? 0 : (storyIndex / (widget.pages.length) * 100).round()}%',
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
    );
  }
}