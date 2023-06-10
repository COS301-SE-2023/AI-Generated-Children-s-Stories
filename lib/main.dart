import 'package:flutter/material.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'home.dart';
import 'myHeader.dart';
import 'inside_story.dart';
import 'package:flutter_test/flutter_test.dart';

//to do hot reload: 
//flutter run
//enter 'r' in the terminal

void main() {
  // testWidgets(
  //   "Find the Here\'s a new book! message on the home screen",
  //   (WidgetTester tester) async {
  //     await tester.pumpWidget(const MyHeader(message: 'Here\'s a new book!',));
  //     final titleFinder = find.text('Here\'s a new book!');
  //     expect(titleFinder, findsOneWidget);
  //   },
  // );
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
      home: Home(),
      routes: {
        '/login': (context) => LoginPage(),
        '/storyList': (context) => StoryList(),
        '/home': (context) => InsideStory(),
        '/insideAStory': ChangeNotifierProvider(
        )
      }
    );
  }
}
