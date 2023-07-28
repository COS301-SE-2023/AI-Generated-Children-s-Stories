import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pages/image_button.dart';

import 'package:magic_pages/main.dart' as app;
import 'package:magic_pages/book_with_progress.dart';
import 'package:magic_pages/progress_bar.dart';
import 'package:magic_pages/story.dart';
import 'package:magic_pages/story_list.dart';

//to run: flutter test integration_test
//choose windows

//checking actions...

void main() {
  group('unit test for story class', () {
    test('test that the story class getters work', () {
      //create a story
      Story story = Story(
          title: "title",
          coverUrl: "coverUrl",
          textContent: ["textContent"],
          imageContent: ["imageContent"],
          currentPage: 0,
          id: 0);

      //check that the getters work
      expect(story.getTitle(), "title");
      expect(story.getCoverUrl(), "coverUrl");
      expect(story.getTextContent(), ["textContent"]);
      expect(story.getImageContent(), ["imageContent"]);
      expect(story.getId(), 0);
      expect(story.getIsLiked(), false);
    });

    test('test that the story class setters work', () {
      //create a story
      Story story = Story(
          title: "title",
          coverUrl: "coverUrl",
          textContent: ["textContent"],
          imageContent: ["imageContent"],
          currentPage: 0,
          id: 0);

      //check that the setters work
      story.setIsLiked(true);
      expect(story.getIsLiked(), true);
    });
  });

  group('end-to-end test', () {
    testWidgets('integration test', (tester) async {
      app.main();

      //--------------------- LOGIN PAGE ----------------//

      //check that the login page is displayed
      expect(find.text('Ask a grown up to help you'), findsOneWidget);

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

  group('unit test the BookWithProgress widget', () {
    testWidgets('test that the widget is displayed', (tester) async {
      //create a story
      Story story = Story(
          title: "title",
          coverUrl: "assets/images/stories/AndyTheAnt/cover.jpg",
          textContent: ["textContent"],
          imageContent: ["imageContent"],
          currentPage: 0,
          id: 0);

      //create a widget
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BookWithProgress(
                  title: story.getTitle(),
                  imagePath: story.getCoverUrl(),
                  id: story.getId(),
                  currentPage: story.getCurrentPage(),
                  totalPages: story.getTextContent().length))));

      //check that the widget is displayed
      expect(find.byType(BookWithProgress), findsOneWidget);

      //check that the story title is displayed
      expect(find.text('title'), findsOneWidget);

      //check that the story cover is displayed
      expect(find.byKey(const Key("StoryCover")), findsWidgets);

      //check that the progress bar is displayed
      expect(find.byType(ProgressBar), findsOneWidget);

      //check that the image button is displayed
      expect(find.byType(ImageButton), findsOneWidget);
    });
  });

  group('unit test the ImageButton widget', () {
    testWidgets('test that the widget is displayed', (tester) async {
      //create a widget
      await tester.pumpWidget(MaterialApp(
          home: const Scaffold(
              body: ImageButton(
                  imagePath: "assets/images/stories/AndyTheAnt/cover.jpg",
                  route: "/storyList")),
          routes: {
            '/storyList': (context) => StoryList(),
          }));

      //check that the widget is displayed
      expect(find.byType(ImageButton), findsOneWidget);

      //check that the image button is displayed
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
