
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_pages/story.dart';

//to run: flutter test integration_test
//choose windows

//checking actions...

void main() {
  test('test classes', () {

    Story story = Story(
        title: "title",
        trailer: "trailer",
        textContent: ["textContent"],
        imageContent: ["imageContent"],
        currentPage: 0,
        id: 1,
        isLiked: true,
        totalPages: 1);

    expect(story.title, "title");
    expect(story.trailer, "trailer");
    expect(story.currentPage, 0);
    expect(story.id, 1);
    expect(story.isLiked, true);
    expect(story.imageContent[0], "imageContent");
    expect(story.textContent[0], "textContent");
  });
}