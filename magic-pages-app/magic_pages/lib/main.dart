import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'get_stories_service.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'story_liked.dart';
import 'home.dart';
import 'profile.dart';

import 'story_list_change_notifier.dart';

/// This is the main file for the app.
/// It contains the main function, which runs the app.
/// It also contains the unit and integration tests.
/// The unit tests test the inside a story class.
/// The integration tests test the get stories service class.

void main() {
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
          child: const LoginPage(),
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
          '/storyLiked': (context) => const StoryLiked(),
          '/profile': (context) => const Profile(),

          //TODO: create an end book page
          '/endBook': (context) => const Home(),
        });
  }
}
