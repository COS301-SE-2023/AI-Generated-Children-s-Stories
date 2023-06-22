import 'package:Magic_Pages/get_stories_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'home.dart';
import 'myHeader.dart';
import 'inside_story.dart';
import 'package:test/test.dart';
import 'get_stories_service.dart';

import 'story_list_change_notifier.dart';

import 'package:mocktail/mocktail.dart';

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
        '/login': (context) => LoginPage(),
        '/storyList': (context) => StoryList(),
        '/home': (context) => Home(),
      }
    );
  }
}
