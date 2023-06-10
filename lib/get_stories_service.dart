import 'dart:convert';

import 'package:flutter/services.dart';

import 'story.dart';

class GetStoriesService {

    //read the json file and reaturn the stories (simulates an api call)
    Future<List<Story>> fetchStories() async {
        await Future.delayed(const Duration(seconds: 1));
        final String response = await rootBundle.loadString('assets/stories.json');
        final data = await json.decode(response);
        return data.map<Story>((json) => Story.fromJson(json)).toList();
    }
}