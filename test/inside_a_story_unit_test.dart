import 'package:flutter/material.dart';
import 'package:magic_pages/inside_story.dart';
import 'package:magic_pages/story_list_change_notifier.dart';
import 'package:magic_pages/get_stories_service.dart';
import 'package:test/test.dart';
import 'package:magic_pages/main.dart';

void main() {
  group('Inside a story unit tests', () {
    //test the inside a story class
    InsideStory insideStory = InsideStory();

    test("inisde a story initial values", () {
      expect(insideStory.messageIndex, 0);
      expect(insideStory.storyIndex, 0);
      expect(insideStory.shownHalfway, false);
    });

    test("next button works", () {
      insideStory.next();
      expect(insideStory.storyIndex, 1);
    });

    test("prev button works", () {
      insideStory.prev();
      expect(insideStory.storyIndex, 0);
    });

    test("halfway message works", () {
      while (insideStory.storyIndex < insideStory.storyText.length / 2) {
        insideStory.next();
      }
      expect(insideStory.shownHalfway, true);
    });
  });

  StoryListChangeNotifier storyListChangeNotifier;
  GetStoriesService getStoriesService;

  group('Inside a story integration tests', () {
    test("get stories service initial values", () {
      getStoriesService = GetStoriesService();
      storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

      expect(storyListChangeNotifier.isLoading, false);
    });

    test("fetch stories works and loading works", () async {
      getStoriesService = GetStoriesService();
      storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

      storyListChangeNotifier.fetchStories();

      expect(storyListChangeNotifier.isLoading, true);
      await storyListChangeNotifier.fetchStories();

      //check that the stories are not empty
      expect(storyListChangeNotifier.stories.length, 3);
      //check that loading is set to false
      expect(storyListChangeNotifier.isLoading, false);
    });

    test("correct story headings shown", () async {
      getStoriesService = GetStoriesService();
      storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);

      storyListChangeNotifier.fetchStories();

      await storyListChangeNotifier.fetchStories();

      expect(storyListChangeNotifier.stories.length, 3);

      //check that the headings are correct
      expect(storyListChangeNotifier.stories[0].title, 'Andy the Ant');
      expect(storyListChangeNotifier.stories[1].title, 'Benny the Bear');
      expect(storyListChangeNotifier.stories[2].coverUrl,
          'assets/storyPreviews/honey-the-kitty.png');
    });
  });
  //test the get stories service class

  runApp(const MyApp());
}
