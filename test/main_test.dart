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
      binding.window.physicalSizeTestValue = const Size(800, 600);

      app.main();

      //---------------------   HOME PAGE ----------------//
      //wait for the current story to load
      await tester.pump(const Duration(seconds: 7));

      //see the book has loaded
      expect(find.text('Continue reading...'), findsOneWidget);

      //check that the currently reading story is there
      expect(find.text('Andy The Ant'), findsOneWidget);

      //navigate to the storyList page
      await tester.tap(find.byKey(const Key("StoryListNav")));

      //------------------- STORY LIST PAGE ----------------//
    });
  });
}
