import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pages/story.dart'; // Import the Story class from your app

void main() {
  late Story story;

  // Setup the story instance before running each test
  setUp(() {
    story = Story(
      title: "Test Story",
      trailer: "test_cover_url",
      textContent: ["Page 1", "Page 2", "Page 3"],
      imageContent: ["image1.png", "image2.png", "image3.png"],
      currentPage: 0,
      id: 1,
      isLiked: false,
    );
  });

  test('Check initial values', () {
    expect(story.getTitle(), "Test Story");
    expect(story.getCoverUrl(), "test_cover_url");
    expect(story.getTextContent(), ["Page 1", "Page 2", "Page 3"]);
    expect(story.getImageContent(), ["image1.png", "image2.png", "image3.png"]);
    expect(story.getCurrentPage(), 0);
    expect(story.getId(), 1);
    expect(story.getIsLiked(), false);
  });

  test('Toggle like status', () {
    expect(story.getIsLiked(), false);
    story.setIsLiked(true);
    expect(story.getIsLiked(), true);
  });

  test('Get next page', () {
    var item = story.getNext();
    expect(item['text'], "Page 2");
    expect(item['image'], "image2.png");
    expect(item['isLast'], false);

    // Move to the last page
    item = story.getNext(); // Change this line
    expect(item['text'], "Page 3"); // Change this line
    expect(item['image'], "image3.png"); // Change this line
    expect(item['isLast'], true);
  });

  test('Get previous page', () {
    // Move to the second page
    story.getNext();
    var prevPage = story.getPrev(); // Change this line
    expect(prevPage['text'], "Page 1"); // Change this line
    expect(prevPage['image'], "image1.png"); // Change this line
    expect(prevPage['isLast'], false);

    // Move to the first page
    prevPage = story.getPrev(); // Change this line
    expect(prevPage['text'], "Page 1"); // Change this line
    expect(prevPage['image'], "image1.png"); // Change this line
    expect(prevPage['isLast'], false);
  });
}
