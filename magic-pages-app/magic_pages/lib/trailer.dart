import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story_change_notifier.dart';
import 'package:magic_pages/story_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

import 'Wave_Widget.dart';
import 'button_widget.dart';
import 'get_stories_service.dart';
import 'global_variables.dart';
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
  TrailerPage({
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
  List<StoryPage> pages = [];

  //change notifier
  final InsideStoryChangeNotifier _insideStoryChangeNotifier =
  InsideStoryChangeNotifier(GetStoriesService());

  void loadImages() async {
    for (StoryPage page in pages) {
      precacheImage(NetworkImage(page.image), context);
      super.didChangeDependencies();
    }
  }

  void fetchPages() async {
    pages = await _insideStoryChangeNotifier.fetchPages(context, widget.id);
    loadImages();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPages();
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
                                  image: AssetImage(
                                      'assets/images/back-button.png'),
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
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: const EdgeInsets.fromLTRB(
                                        64, 0, 64, 0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/images/mascot-winking.png'),
                                              width: 50,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
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
                                    margin: const EdgeInsets.fromLTRB(
                                        64, 32, 64, 16),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        widget.imagePath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      64, 0, 64, 0),
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
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: getReadNowButton()
                      )
                    ]
                ),
              ]
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 3),
    );
  }

  Widget getReadNowButton() {
    if (_insideStoryChangeNotifier.isLoading) {
      return const ButtonWidget( //disable
        message: 'ON ITS WAY',
        destination: '/insideStory',
        isEnabled: false,
      );
    } else {
      print("pages:");
      print(pages);

      return ButtonWidget( //enable
        message: 'READ NOW',
        destination: '/insideStory',
        storyId: widget.id,
        currentPage: widget.currentPage,
        pages: pages
      );
    }
  }


  void likeStory(bool mustLike) async {
    List<String> idToken = await GlobalVariables.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];

    try {
      final url = Uri.parse(
          "http://${GlobalVariables.ipAddress}/liked/stories");

      final Map<String, dynamic> data = {
        "userId": id,
        "storyId": widget.id.toString()
      };

      http.Response response;

      if (mustLike) {
        response = await http.post(
          url,
          body: data,
        );
      } else {
        response = await http.delete(
          url,
          body: data,
        );
      }

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        GlobalVariables.showSnackbarMessage(
            "Error from post: ${response.body}", context);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget HeartToggle() {
    Image image;
    if (widget.isLiked == true) {
      image =  const Image(image: AssetImage('assets/images/heart.png'), width: 30);
    } else {
      image =  const Image(image: AssetImage('assets/images/heart-outline.png'), width: 30);
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
                likeStory(true);
                isHeartAnimating = true;
              } else {
                likeStory(false);
              }
            });
          },
          child: image,
        ),
      ),
    );
  }
}


