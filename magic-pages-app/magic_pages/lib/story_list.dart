import 'package:magic_pages/book_with_progress.dart';

import 'story.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'my_header.dart';
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
      backgroundColor: const Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
        child: SingleChildScrollView(
            child: _storyListChangeNotifier.isLoading
                ? const Column(
                    children: [
                      MyHeader(
                        message: 'Getting books...',
                      ),
                      CircularProgressIndicator(),
                    ],
                  )
                : //scrollable list of stories
                Column(
                    children: [
                      const MyHeader(
                        message: 'Books',
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var story in _stories)
                              //book with progress bar
                              BookWithProgress(
                                title: story.getTitle(),
                                imagePath: story.getCoverUrl(),
                                id: story.getId(),
                                currentPage: story.getCurrentPage(),
                                totalPages: story.getTextContent().length,
                              ),
                          ],
                        ),
                      ),
                    ],
                  )),
      ),
      bottomNavigationBar: const NavbarWidget(active: 0),
    );
  }
}
