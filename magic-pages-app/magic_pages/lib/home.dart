import 'package:flutter/material.dart';
import 'package:magic_pages/wave_widget.dart';

import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'home_change_notifier.dart';
import 'get_stories_service.dart';
import 'story.dart';
import 'book_with_progress.dart';

/// This class represents the home page.
/// It contains the UI for the home page.
/// The UI contains a header, a progress bar, an image, an image caption, and an image button.
/// The header tells the user if they are reading a new book or continuing to read the book they were reading.
/// The progress bar shows the user how far they are through the book.
/// The image shows the user the cover of the book they are reading.
/// The image caption tells the user the title of the book they are reading.
/// The image button takes the user to the inside a story page.

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //change notifier
  final HomeChangeNotifier _homeChangeNotifier =
      HomeChangeNotifier(GetStoriesService());

  late List<Story> _currentlyReadingStory;

  //set story to empty story
  //fetch currently reading
  @override
  void initState() {
    super.initState();
    getCurrentlyReading(context);
  }

  //fetch currently reading
  //it uses the home change notifier to fetch the currently reading story
  void getCurrentlyReading(BuildContext context) async {
    await _homeChangeNotifier.fetchCurrentlyReading(context);

    setState(() {
      _currentlyReadingStory = _homeChangeNotifier.currentlyReadingStory;
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
              Column(children: [
                //if loading, show loading message
                _homeChangeNotifier.isLoading
                    ? const Column(
                        children: [
                          MyHeader(
                            message: 'Getting your story...',
                          ),
                          CircularProgressIndicator(),
                        ],
                      )
                    : _homeChangeNotifier.isNewBook
                        ? const MyHeader(
                            message: 'Here\'s a new book!',
                          )
                        : const MyHeader(
                            message: 'Welcome back!\nKeep reading your books.',
                          ),
                !_homeChangeNotifier.isLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).padding.bottom + 94 + 138),
                        child: ScrollSnapList(
                          itemBuilder: _currentlyReadingListItem,
                          itemCount: _currentlyReadingStory.length,
                          itemSize: 469,
                          onItemFocus: (index) {},
                          dynamicItemSize: true,
                          scrollDirection: Axis.vertical,
                        ),
                      )
                    : const SizedBox(height: 30),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 1),
    );
  }

  Widget _currentlyReadingListItem(BuildContext context, int index) {
    Story story = _currentlyReadingStory[index];

    return BookWithProgress(
      title: story.title,
      imagePath: story.trailer,
      id: story.id,
      currentPage: story.currentPage,
      totalPages: story.textContent.length,
      isLiked: story.isLiked
    );
  }
}