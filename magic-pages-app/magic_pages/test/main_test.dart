import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_pages/main.dart' as app;
import 'package:magic_pages/book_with_progress.dart';

//to run: flutter test integration_test
//choose windows
void main() {
  group('end-to-end test', () {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('integration test', (tester) async {
      //set windows size to 800x600
      // ignore: deprecated_member_use
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
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //------------------- STORY LIST PAGE ----------------//

      expect(find.text('Books'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //check that the list of stories is displayed

      //multiple widgets of this type are displayed
      expect(find.byType(BookWithProgress), findsWidgets);

      //other stories that should be displayed
      expect(find.text('Honey the Kitty'), findsOneWidget);
      expect(find.text('Benny the Bear'), findsOneWidget);
    });
  });
}
