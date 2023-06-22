import 'package:Magic_Pages/get_stories_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'home.dart';

import 'story_list_change_notifier.dart';

//to do hot reload:
//flutter run
//enter 'r' in the terminal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Header Widget Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => StoryListChangeNotifier(GetStoriesService()),
          child: Home(),
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
        });
  }
}
