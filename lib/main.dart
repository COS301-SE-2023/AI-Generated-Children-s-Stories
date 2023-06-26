import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/test.dart';

import 'get_stories_service.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'inside_story.dart';
import 'home.dart';
import 'story_list_change_notifier.dart';

//to do hot reload:
//flutter run
//enter 'r' in the terminal

void main() {
  GetStoriesService getStoriesService;
  StoryListChangeNotifier storyListChangeNotifier;

  //----------------------- UNIT TESTS -----------------------//

  InsideStory insideStory = InsideStory();

  //test initial values
  test("inisde a story initial values", () {
    expect(insideStory.messageIndex, 0);
    expect(insideStory.storyIndex, 0);
    expect(insideStory.shownHalfway, false);
  });

  group('Inside a story test', () {
    test("next button works", () {
      insideStory.next();
      expect(insideStory.storyIndex, 1);
    });

    test("prev button works", () {
      insideStory.prev();
      expect(insideStory.storyIndex, 0);
    });

    test("halfway message works", () {
      insideStory.next();
      insideStory.next();
      expect(insideStory.shownHalfway, true);
    });
  });

  //----------------------------------------------------------//

  //-------------------- INTEGRATION TEST --------------------//

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
        title: 'Flutter Header Widget Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => StoryListChangeNotifier(GetStoriesService()),
          child: const Home(),
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/storyList': (context) => StoryList(),
          '/home': (context) => const Home(),
          '/insideAStory': (context) => InsideStory(),
        });
  }
}
