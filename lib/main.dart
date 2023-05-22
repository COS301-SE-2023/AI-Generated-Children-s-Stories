import 'package:flutter/material.dart';
import 'login_page.dart';
import 'story_list.dart';
import 'home.dart';

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
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/storyList': (context) => StoryList(),
        '/home': (context) => Home(),
      }
    );
  }
}
