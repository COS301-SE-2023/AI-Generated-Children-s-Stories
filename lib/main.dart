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

  test("initial_values", () {
    getStoriesService = GetStoriesService();
    storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

    expect(storyListChangeNotifier.stories, []);
    expect(storyListChangeNotifier.isLoading, false);
  });

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
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
          '/insideAStory': (context) => InsideStory(),
        });
  }
}
