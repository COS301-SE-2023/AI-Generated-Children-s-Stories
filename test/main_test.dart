import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_pages/main.dart' as app;

//to run: flutter test integration_test
//choose windows
void main() {
  group('end-to-end test', () {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('integration test', (tester) async {
      //set windows size to 800x600
      binding.window.physicalSizeTestValue = const Size(300, 600);

      app.main();

      //---------------------   HOME PAGE ----------------//

      //loading message
      /* expect(find.text('Getting your story...'), findsOneWidget);

      //wait for the current story to load
      await tester.pump(const Duration(seconds: 7));

      //see the book has loaded
      expect(find.text('Continue reading...'), findsOneWidget);

      //check that the image is displayed
      expect(find.byKey(const Key('HomeImage')), findsOneWidget);*/

      //navigate to the storyList page
      await tester.tap(find.byKey(const Key("StoryListNav")));

      //wait for the page to load
      await tester.pumpAndSettle();

      //------------------- STORY LIST PAGE ----------------//

      //loading message
      expect(find.text('Getting books...'), findsOneWidget);

      //wait for the current stories to load
      await tester.pump(const Duration(seconds: 7));

      expect(find.text('Andy the Ant'), findsOneWidget);
      expect(find.text('Beny The Bear'), findsOneWidget);
      expect(find.text('Honey The Kitty'), findsOneWidget);
    });
  });
}
