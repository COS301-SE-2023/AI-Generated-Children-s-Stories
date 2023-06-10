import 'package:Magic_Pages/story.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:Magic_Pages/story_list_change_notifier.dart';
import 'package:Magic_Pages/get_stories_service.dart';

class MockGetStoriesService extends Mock implements GetStoriesService {}

void main() {
  late StoryListChangeNotifier storyListChangeNotifier;
  late MockGetStoriesService getStoriesService;

  setUp(() {
    getStoriesService = MockGetStoriesService();
    storyListChangeNotifier = StoryListChangeNotifier(getStoriesService);
  });

  group('StoryList', () {
    test(
      "initial values correct",
      () {
        //stories initially empty
        expect(storyListChangeNotifier.stories, []);
        expect(storyListChangeNotifier.isLoading, false);
      },
    );
    test(
      "should return a list of stories",
      () async {
        final stories = await getStoriesService.fetchStories();
        expect(stories.length, 3);
      },
    );
    
    test(
      'gets stories service called when fetch stories is called',
      () async {
        //mock the service
        when(() => getStoriesService.fetchStories()).thenAnswer((_) async => []);
        await storyListChangeNotifier.fetchStories();
        //see that fetch stories is being called
        verify(() => getStoriesService.fetchStories()).called(1);
      },
    );

    List<Story> testStories = [
      Story(
            title: 'Andy the Ant',
            coverUrl: 'assets/storyPreviews/andy-the-ant.png',
            textContent: [
              "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
              "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unloc, ked, but he was determined to find out.",
              "Carrying the key, Andy went on an exciting journey through tall grass, up branches, and across a tiny stream. Finally, he discovered a huge rock with door.",
              "Andy turned the key in the keyhole, and the door opened, revealing a hidden chamber. Inside, there was delicious food."
            ],
            imageContent: [
              "assets/images/stories/AndyTheAnt/img1.jpg",
              "assets/images/stories/AndyTheAnt/img2.jpg",
              "assets/images/stories/AndyTheAnt/img3.jpg",
              "assets/images/stories/AndyTheAnt/img4.jpg"
            ]
          ),
      Story(
            title: 'Andy the Ant',
            coverUrl: 'assets/storyPreviews/andy-the-ant.png',
            textContent: [
              "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
              "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unloc, ked, but he was determined to find out.",
              "Carrying the key, Andy went on an exciting journey through tall grass, up branches, and across a tiny stream. Finally, he discovered a huge rock with door.",
              "Andy turned the key in the keyhole, and the door opened, revealing a hidden chamber. Inside, there was delicious food."
            ],
            imageContent: [
              "assets/images/stories/AndyTheAnt/img1.jpg",
              "assets/images/stories/AndyTheAnt/img2.jpg",
              "assets/images/stories/AndyTheAnt/img3.jpg",
              "assets/images/stories/AndyTheAnt/img4.jpg"
            ]
          ),
    ];

    test(
      "check that isloading flag is true, sets stories to one's read from file, sets isloading flag to false", 
      () async {
        when(() => getStoriesService.fetchStories()).thenAnswer((_) async => testStories);

        final future = storyListChangeNotifier.fetchStories();
        //see that fetch stories is being called
        expect(storyListChangeNotifier.isLoading, true);

        await future;
        verify(() => getStoriesService.fetchStories()).called(1);
        expect(storyListChangeNotifier.stories, testStories);
        expect(storyListChangeNotifier.isLoading, false);
      }
    );
  });

}

