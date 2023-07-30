import 'Wave_Widget.dart';
import 'story.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'book_widget.dart';
import 'story_list_change_notifier.dart';
import 'get_stories_service.dart';

/// This class represents the story list page.
/// The UI contains a header and a list of stories.
/// The list of stories shows the user the list of stories they can read.

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  State<StoryList> createState() => _StoryListState();

  //for testing purposes
  isLoading() {
    return _StoryListState()._storyListChangeNotifier.isLoading;
  }
}

class _StoryListState extends State<StoryList> {
  late List<Story> _stories;

  //change notifier
  final StoryListChangeNotifier _storyListChangeNotifier =
      StoryListChangeNotifier(GetStoriesService());

  /// set stories to empty list
  /// @return void
  @override
  void initState() {
    super.initState();
    getStories();
    _stories = [];
  }

  /// fetch stories
  /// it uses the story list change notifier to fetch the list of stories
  /// @return void
  void getStories() async {
    await _storyListChangeNotifier.fetchStories();
    setState(() {
      _stories = _storyListChangeNotifier.stories;
    });
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
                  _storyListChangeNotifier.isLoading
                      ? Column(
                          children: [
                            Container(
                              height: 124,
                              margin: const EdgeInsets.only(top: 50.0),
                              child: Center(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 42.5),
                                            width: 150,
                                            child: const Text(
                                              'Getting books...',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF542209),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 40.0),
                                            child:  Transform.rotate(
                                              angle: 0.125,
                                              child: const Image(
                                                image: AssetImage('assets/images/mascot.png'),
                                                width: 150,
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                            ),
                            const CircularProgressIndicator(),
                          ],
                        )
                      : //scrollable list of stories
                      Column(
                          children: [
                            Container(
                              height: 124,
                              margin: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                              child: Center(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 42.5),
                                            width: 150,
                                            child: const Text(
                                              'This is all the books we have.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF542209),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 40.0),
                                            child:  Transform.rotate(
                                              angle: 0.125,
                                              child: const Image(
                                                image: AssetImage('assets/images/mascot.png'),
                                                width: 150,
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                            ),
                          ]
                      ),
                      !_storyListChangeNotifier.isLoading
                  ? SizedBox(
                    height: MediaQuery.of(context).size.height-(MediaQuery.of(context).padding.top+288),
                    child: ListView.builder(
                      itemCount: _stories.length,
                      itemBuilder: _BookListItem,                        
                    ),
                  )
                  : const SizedBox(height: 30),
                ]
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 0),
    );
    
    // Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 255, 243, 233),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //         child: _storyListChangeNotifier.isLoading
    //             ? const Column(
    //                 children: [
    //                   MyHeader(
    //                     message: 'Getting books...',
    //                   ),
    //                   CircularProgressIndicator(),
    //                 ],
    //               )
    //             : //scrollable list of stories
    //             Column(
    //                 children: [
    //                   const MyHeader(
    //                     message: 'Books',
    //                   ),
    //                   const SizedBox(height: 20),
    //                   Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         for (var story in _stories)
    //                           //book with progress bar
    //                           BookWithProgress(
    //                             title: story.getTitle(),
    //                             imagePath: story.getCoverUrl(),
    //                             id: story.getId(),
    //                             currentPage: story.getCurrentPage(),
    //                             totalPages: story.getTextContent().length,
    //                           ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               )),
    //   ),
    //   bottomNavigationBar: const NavbarWidget(active: 0),
    // );
  }
  Widget _BookListItem(BuildContext context, int index) {
    if (index.isOdd) {
      return const SizedBox(height: 0);
    }
    Story story1 = _stories[index];
    Story story2 = _stories[index];
    if (index < _stories.length-1) {
      story2 = _stories[index+1];
    }
    return _stories.length.isEven
      ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: BookWidget(
            title: story1.getTitle(),
            imagePath: story1.getCoverUrl(),
            id: story1.getId(),
            currentPage: story1.getCurrentPage(),
            totalPages: story1.getTextContent().length,
            isLiked: story1.getIsLiked(),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(0, 10, 16, 10),
          child: BookWidget(
            title: story2.getTitle(),
            imagePath: story2.getCoverUrl(),
            id: story2.getId(),
            currentPage: story2.getCurrentPage(),
            totalPages: story2.getTextContent().length,
            isLiked: story2.getIsLiked(),
          ),
        ),
      ]
    )
    : index < _stories.length-1 
    ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: BookWidget(
            title: story1.getTitle(),
            imagePath: story1.getCoverUrl(),
            id: story1.getId(),
            currentPage: story1.getCurrentPage(),
            totalPages: story1.getTextContent().length,
            isLiked: story1.getIsLiked(),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(0, 10, 16, 10),
          child: BookWidget(
            title: story2.getTitle(),
            imagePath: story2.getCoverUrl(),
            id: story2.getId(),
            currentPage: story2.getCurrentPage(),
            totalPages: story2.getTextContent().length,
            isLiked: story2.getIsLiked(),
          ),
        ),
      ]
    )
    : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: BookWidget(
            title: story1.getTitle(),
            imagePath: story1.getCoverUrl(),
            id: story1.getId(),
            currentPage: story1.getCurrentPage(),
            totalPages: story1.getTextContent().length,
            isLiked: story1.getIsLiked(),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/2-32,
          margin: const EdgeInsets.fromLTRB(0, 10, 16, 10),
          child: const SizedBox(height: 0),
        )
      ]
    );
  }
}
