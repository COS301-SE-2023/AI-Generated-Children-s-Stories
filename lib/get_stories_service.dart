import 'story.dart';

class GetStoriesService {
    final stories = List.generate(
        5, 
        (i) => Story(
            title: 'Andy the Ant',
            coverUrl: 'assets/stories/AndyTheAnt/cover.jpg',
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
    );

    Future<List<Story>> fetchStories() async {
        await Future.delayed(const Duration(seconds: 1));
        return stories;
    }
}