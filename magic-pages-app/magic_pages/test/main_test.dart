import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_pages/main.dart' as app;
import 'package:magic_pages/book_with_progress.dart';

//to run: flutter test integration_test
//choose windows

//checking actions...

void main() {
  group('end-to-end test', () {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('integration test', (tester) async {
      app.main();

      //--------------------- LOGIN PAGE ----------------//

      //check that the login page is displayed
      expect(find.text('Ask a grown up to help you log in.'), findsOneWidget);

      //ensure login button is present
      expect(find.byKey(const Key('GoogleLogin')), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('GoogleLogin')));
      await tester.pumpAndSettle();

      GestureDetector googleButton = find
          .byKey(const Key('GoogleLogin'))
          .evaluate()
          .first
          .widget as GestureDetector;

      googleButton.onTap!();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //--------------------- HOME PAGE ----------------//

      //see the book has loaded
      expect(find.text('Continue reading...'), findsOneWidget);

      //check that the book is displayed
      expect(find.byKey(const Key('BookWithProgress')), findsOneWidget);

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
