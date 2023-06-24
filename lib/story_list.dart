import 'story.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'story_list_change_notifier.dart';
import 'get_stories_service.dart';

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  late List<Story> _stories;

  //change notifier
  final StoryListChangeNotifier _storyListChangeNotifier =
      StoryListChangeNotifier(GetStoriesService());

  @override
  void initState() {
    super.initState();
    getStories();
    _stories = [];
  }

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

          _storyListChangeNotifier.isLoading
              ? const Column(
                  children: [
                    MyHeader(
                      message: 'Geting stories...',
                    ),
                    SizedBox(height: 50),
                    CircularProgressIndicator(),
                  ],
                )
              : const Column(
                  children: [
                    MyHeader(
                      message: 'Stories',
                    ),
                    SizedBox(height: 50),
                  ],
                ),

          //the story list
          !_storyListChangeNotifier.isLoading
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _stories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            //padding
                            const SizedBox(height: 20),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1.5,
                              child: Column(
                                children: [
                                  Image.asset(
                                    _stories[index].coverUrl,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 5),

                            DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 35,
                                  //rgb(84, 34, 9)
                                  color: Color.fromARGB(255, 84, 34, 9),
                                  fontFamily: 'NotoSerif'),
                              child: Text(_stories[index].title),
                            ),

                            const SizedBox(height: 5),

                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child:
                                    Image.asset('assets/images/viewButton.png'),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              : const SizedBox(height: 0),
        ],
      )),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
