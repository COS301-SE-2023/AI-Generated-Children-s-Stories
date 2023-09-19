import 'package:flutter/material.dart';
import 'package:magic_pages/story_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'wave_widget.dart';
import 'globals.dart';
import 'heart_toggle.dart';
import 'inside_story.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;

class EndOfStory extends StatefulWidget {
  final int storyId;
  final List<StoryPage> pages;
  final bool isLiked;
  final void Function(int) updatePage;
  final void Function(bool) updateLiked;

  const EndOfStory({
    super.key,
    required this.storyId,
    required this.pages,
    required this.isLiked,
    required this.updatePage,
    required this.updateLiked
  });

  @override
  State<EndOfStory> createState() => _EndOfStoryState();
}

class _EndOfStoryState extends State<EndOfStory> {
  bool isHeartAnimating = false;
  late bool isLiked = widget.isLiked;
  bool isHomePressed = false;
  bool isAgainPressed = false;
  late double screenHeight = MediaQuery.of(context).size.height;

  Future<void> deleteProgress() async {
    final url = Uri.parse("http://${Globals.ipAddress}/deleteProgress");

    List<String> idToken = await Globals.getIdAndToken();

    //{"apiKey":"aac7c266-aa4c-49c2-80d4-7f7e54c688a4", "userId":2, "storyId":5, "pageNumber":2}
    final jsonString = "{\"apiKey\":\"${idToken[1]}\", \"userId\":${idToken[0]}, \"storyId\":${widget.storyId}, \"pageNumber\":0}}";
    final data = jsonString;

    http.Response response = await http.delete(
        url,
        headers: {
          'content-type': 'application/json; charset=utf-8'
        },
        body: data
    );

    if (response.statusCode == 200) {
      print("Sent data: ");
      print(response.body);
    } else {
      Globals.showSnackbarMessage("Error: ${response.body}", context);
    }
  }

  @override
  void initState() {
    super.initState();
    deleteProgress();
  }

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
                          image: AssetImage('assets/images/mascot-winking.png'),
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
                        HeartToggle(id: widget.storyId, isLiked: widget.isLiked, updateLiked: widget.updateLiked),
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
                        widget.updatePage(1);
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => InsideStory(
                            storyId: widget.storyId,
                            currentPage: 0,
                            pages: widget.pages,
                            isLiked: isLiked,
                            updatePage: widget.updatePage,
                            updateLiked: widget.updateLiked,
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
}