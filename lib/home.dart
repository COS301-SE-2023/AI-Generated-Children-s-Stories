import 'package:flutter/material.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'image_button.dart';
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

  late Story _currentlyReadingStory;

  //set story to empty story
  //fetch currently reading
  @override
  void initState() {
    super.initState();
    getCurrentlyReading();
    _currentlyReadingStory = Story(
        title: '',
        coverUrl: '',
        textContent: [],
        imageContent: [],
        currentPage: 0,
        id: 0);
  }

  //fetch currently reading
  //it uses the home change notifier to fetch the currently reading story
  void getCurrentlyReading() async {
    await _homeChangeNotifier.fetchCurrentlyReading();
    setState(() {
      _currentlyReadingStory = _homeChangeNotifier.currentlyReadingStory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
        //back button
        child: SingleChildScrollView(
          child: Column(
            key: Key('TestKey'),
            children: [
              //if loading, show loading message
              _homeChangeNotifier.isLoading
                  ? const Column(
                      children: [
                        MyHeader(
                          message: 'Getting your story...',
                        ),
                        SizedBox(height: 50),
                        CircularProgressIndicator(),
                      ],
                    )
                  :

                  //else show the correct header
                  _homeChangeNotifier.isNewBook
                      ? const MyHeader(
                          message: 'Here\'s a new book!',
                        )
                      : const MyHeader(
                          message: 'Continue reading...',
                        ),

              //padding
              const SizedBox(height: 30),

              !_homeChangeNotifier.isLoading
                  ? BookWithProgress(
                      title: _currentlyReadingStory.title,
                      imagePath: _currentlyReadingStory.coverUrl,
                      id: _currentlyReadingStory.id,
                      currentPage: _currentlyReadingStory.currentPage,
                      totalPages: _currentlyReadingStory.textContent.length,
                    )
                  : const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
