import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story_change_notifier.dart';
import 'package:magic_pages/story_page.dart';

import 'wave_widget.dart';
import 'button_widget.dart';
import 'get_stories_service.dart';
import 'heart_toggle.dart';
import 'navbar.dart';

/// This class represents...

class TrailerPage extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;
  final bool isLiked;

  // ignore: use_key_in_widget_constructors
  const TrailerPage({
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
  late bool isLiked = widget.isLiked;
  late int currentPage = widget.currentPage;

  //change notifier
  final InsideStoryChangeNotifier _insideStoryChangeNotifier =
  InsideStoryChangeNotifier(GetStoriesService());

  void updatePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  void updateLiked(bool updatedIsLiked) {
    print("updating liked in trailer to $updatedIsLiked");
    setState(() {
      isLiked = updatedIsLiked;
    });
  }

  void updateUi() {
    setState(() {});
  }

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
                                Navigator.pop(context);
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
                                        HeartToggle(id: widget.id, isLiked: isLiked, updateLiked: updateLiked),
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
      return ButtonWidget( //enable
        message: 'READ NOW',
        destination: '/insideStory',
        storyId: widget.id,
        currentPage: currentPage,
        pages: pages,
        isLiked: isLiked,
        updatePage: updatePage,
        updateLiked: updateLiked
      );
    }
  }

}



