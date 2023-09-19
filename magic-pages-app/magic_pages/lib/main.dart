import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_pages/inside_story_change_notifier.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'get_stories_service.dart';
import 'signup_page.dart';
import 'story_list.dart';
import 'story_liked.dart';
import 'home.dart';
import 'profile.dart';
import 'splash.dart';

import 'story_list_change_notifier.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';


/// This is the main file for the app.
/// It contains the main function, which runs the app.
/// It also contains the unit and integration tests.
/// The unit tests test the inside a story class.
/// The integration tests test the get stories service class.
///
/// Generate firebase keys:
/// go to android folder
/// ./gradlew signingReport
/// Use sha1 and sha256
/// add to android section in firebase

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Conditionally initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterSecureStorage storage = FlutterSecureStorage();
  String? id = await storage.read(key: 'id');
  String? token = await storage.read(key: 'api_token');

  bool loggedInPreviously = false;

  if (id != null && token != null){
    print("logged in already...");
    loggedInPreviously = true;
  } else {
    print("not logged in preveously");
  }

  runApp(MyApp(loggedInPreviously));
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
  final bool loggedInPreviously;

  const MyApp(this.loggedInPreviously, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<InsideStoryChangeNotifier>(
            create: (context) => InsideStoryChangeNotifier(GetStoriesService()),
          ),
          ChangeNotifierProvider<StoryListChangeNotifier>(
              create: (context) => StoryListChangeNotifier(GetStoriesService())
          )
        ],
        child: MaterialApp(
            title: 'Magic Pages',
            theme: ThemeData(
              primarySwatch: createMaterialColor(const Color(0xFFFE8D29)),
              scaffoldBackgroundColor: const Color(0xFFFFF3E9),
            ),
            home:  loggedInPreviously ? const Home() : const SplashPage(),
            routes: {
              '/signup': (context) => const SignupPage(),
              '/splash': (context) => const SplashPage(),
              '/storyList': (context) => const StoryList(),
              '/home': (context) => const Home(),
              '/storyLiked': (context) => const StoryLiked(),
              '/profile': (context) => const Profile(),
            })
    );
  }

}

/*
class MyApp extends StatelessWidget {

  MyApp({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InsideStoryChangeNotifier>(
          create: (context) => InsideStoryChangeNotifier(GetStoriesService()),
        ),
        ChangeNotifierProvider<StoryListChangeNotifier>(
          create: (context) => StoryListChangeNotifier(GetStoriesService())
        )
      ],
    child: MaterialApp(
        title: 'Magic Pages',
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFFFE8D29)),
          scaffoldBackgroundColor: const Color(0xFFFFF3E9),
        ),
        home:  const SplashPage(),
        routes: {
          '/signup': (context) => const SignupPage(),
          '/splash': (context) => const SplashPage(),
          '/storyList': (context) => const StoryList(),
          '/home': (context) => const Home(),
          '/storyLiked': (context) => const StoryLiked(),
          '/profile': (context) => const Profile(),
        })
    );
  }
}*/
