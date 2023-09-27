import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_pages/main.dart' as app;
import 'package:magic_pages/book_with_progress.dart';
import 'package:magic_pages/story.dart';

//to run: flutter test integration_test
//choose windows

//checking actions...

void main() {
  test('test classes', () {

    Story story = Story(
        title: "title",
        trailer: "trailer",
        textContent: ["textContent"], imageContent: ["imageContent"], currentPage: 0, id: 1, isLiked: true);

    expect(story.getTitle(), "title");
    expect(story.getCoverUrl(), "trailer");
    expect(story.getCurrentPage(), 0);
    expect(story.getId(), 1);
    expect(story.getIsLiked(), true);
    expect(story.getImageContent()[0], "imageContent");
    expect(story.getTextContent()[0], "textContent");
  });
}