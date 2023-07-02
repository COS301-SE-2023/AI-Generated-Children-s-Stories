import 'package:flutter/material.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'image_button.dart';
import 'home_change_notifier.dart';
import 'get_stories_service.dart';
import 'story.dart';

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
    );
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
                  ? Row(children: [
                      //image with rounded corners
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage(_currentlyReadingStory.coverUrl),
                              ),
                            ),
                          ))
                      //tablet
                    ])
                  : const SizedBox(height: 0),

              Row(
                children: [
                  //image caption
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1, top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        _currentlyReadingStory.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            //hex color
                            color: Color.fromARGB(255, 84, 34, 9),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              !_homeChangeNotifier.isLoading
                  ? const Row(
                      children: [
                        //image button
                        ImageButton(
                          imagePath: 'assets/images/viewButton.png',
                          route: '/insideAStory',
                        )
                      ],
                    )
                  : const SizedBox(height: 0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
