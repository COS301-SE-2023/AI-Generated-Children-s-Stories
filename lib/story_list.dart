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
          child: Column(
        children: [
          //the header

          //if the story list is loading
          //show loading message
          //else show the header
          _storyListChangeNotifier.isLoading
              ? const Column(
                  children: [
                    MyHeader(
                      message: 'Getting books...',
                    ),
                    CircularProgressIndicator(),
                  ],
                )
              : const Column(
                  children: [
                    MyHeader(
                      message: 'Book Library',
                    ),
                  ],
                ),

          //the story list
          !_storyListChangeNotifier.isLoading
              ?
              //list of stories
              Expanded(
                  child: ListView.builder(
                      itemCount: _stories.length,
                      itemBuilder: (context, index) {
                        //list of book with progress
                        return BookWithProgress(
                          title: _stories[index].getTitle(),
                          imagePath: _stories[index].getCoverUrl(),
                          id: _stories[index].getId(),
                          currentPage: _stories[index].getCurrentPage(),
                          totalPages: _stories[index].getTextContent().length,
                        );
                      }))
              : const SizedBox(height: 0),
        ],
      )),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
