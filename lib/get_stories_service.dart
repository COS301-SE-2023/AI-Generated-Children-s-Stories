import 'dart:convert';
import 'dart:html';

import 'package:flutter/services.dart';

import 'story.dart';

class GetStoriesService {
  //read the json file and reaturn the stories (simulates an api call)
  //continue with integration tests

  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString('assets/stories.json');
    final data = await json.decode(response);

    List<Story> stories = [];

    for (var i = 0; i < data.length; i++) {
      stories.add(Story(
        title: data[i]['title'],
        coverUrl: data[i]['coverUrl'],
        textContent: data[i]['textContent'].cast<String>(),
        imageContent: data[i]['imageContent'].cast<String>(),
      ));
    }

    return stories;
  }
}
