import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/test.dart';

import 'get_stories_service.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'story_liked.dart';
import 'inside_story.dart';
import 'home.dart';
import 'profile.dart';

import 'story_list_change_notifier.dart';

/// This is the main file for the app.
/// It contains the main function, which runs the app.
/// It also contains the unit and integration tests.
/// The unit tests test the inside a story class.
/// The integration tests test the get stories service class.

void main() {
  //initialise the services and change notifiers
  GetStoriesService getStoriesService;
  StoryListChangeNotifier storyListChangeNotifier;

  //-------------------- INTEGRATION TEST --------------------//

  //test the get stories service class
  test("get stories service initial values", () {
    getStoriesService = GetStoriesService();
    storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

    expect(storyListChangeNotifier.isLoading, false);
  });

  test("fetch stories works and loading works", () async {
    getStoriesService = GetStoriesService();
    storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

    storyListChangeNotifier.fetchStories();

    expect(storyListChangeNotifier.isLoading, true);
    await storyListChangeNotifier.fetchStories();

    //check that the stories are not empty
    expect(storyListChangeNotifier.stories.length, 3);
    //check that loading is set to false
    expect(storyListChangeNotifier.isLoading, false);
  });

  test("correct story headings shown", () async {
    getStoriesService = GetStoriesService();
    storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

    storyListChangeNotifier.fetchStories();

    await storyListChangeNotifier.fetchStories();

    expect(storyListChangeNotifier.stories.length, 3);

    //check that the headings are correct
    expect(storyListChangeNotifier.stories[0].title, 'Andy the Ant');
    expect(storyListChangeNotifier.stories[1].title, 'Benny the Bear');
    expect(storyListChangeNotifier.stories[2].coverUrl,
        'assets/storyPreviews/honey-the-kitty.png');
  });

  //----------------------------------------------------------//

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magic Pages',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => StoryListChangeNotifier(GetStoriesService()),
          child: const Home(),
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
          '/insideAStory': (context) => InsideStory(),
          '/storyLiked': (context) => const StoryLiked(),
          '/profile': (context) => const Profile(),
        });
  }
}