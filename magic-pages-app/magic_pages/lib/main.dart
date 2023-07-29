import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'get_stories_service.dart';
import 'inside_story.dart';
import 'signup_page.dart';
import 'story_list.dart';
import 'story_liked.dart';
import 'home.dart';
import 'profile.dart';
import 'splash.dart';

import 'story_list_change_notifier.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// This is the main file for the app.
/// It contains the main function, which runs the app.
/// It also contains the unit and integration tests.
/// The unit tests test the inside a story class.
/// The integration tests test the get stories service class.

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magic Pages',
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF43932A)),
          scaffoldBackgroundColor: const Color(0xFFFFF3E9),
        ),
        home: ChangeNotifierProvider(
          create: (context) => StoryListChangeNotifier(GetStoriesService()),
          child: const SplashPage(),
        ),
        routes: {
          '/signup': (context) => SignupPage(),
          '/splash': (context) => SplashPage(),
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
          '/storyLiked': (context) => const StoryLiked(),
          '/profile': (context) => const Profile(),
          '/insideAStory': (context) => InsideStory(id: null),

          //TODO: create an end book page
          '/endBook': (context) => const Home(),
        });
  }
}
