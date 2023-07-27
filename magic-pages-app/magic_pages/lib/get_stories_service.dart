import 'dart:convert';
import 'package:flutter/services.dart';
import 'story.dart';

/// This class represents the service that gets the stories from the json file.
/// It contains the fetchStories function, which reads the json file and returns the stories.
/// It also contains the fetchCurrentlyReading function, which reads the json file and returns the currently reading story.
/// The fetchCurrentlyReading function is not used in the app.
/// The fetchCurrentlyReading function is used by the home page to display the currently reading book.
/// The fetchStories function is used in the StoryList class to display the list of stories to the user.

class GetStoriesService {
  //read the json file and return the stories (simulates an api call)
  //continue with integration tests

  Future<List<Story>> fetchStories() async {
    //await Future.delayed(const Duration(seconds: 5));
    final String response = await rootBundle.loadString('assets/data/stories.json');
    final data = await json.decode(response);

    List<Story> stories = [];

    //add a new story object to the list of stories for each story in the json file
    for (var i = 0; i < data.length; i++) {
      stories.add(Story(
          title: data[i]['title'],
          coverUrl: data[i]['coverUrl'],
          textContent: data[i]['textContent'].cast<String>(),
          imageContent: data[i]['imageContent'].cast<String>(),
          currentPage: data[i]['currentPage'],
          isLiked: data[i]['isLiked'],
          id: data[i]['id']));
    }

    return stories;
  }

  //read the json file and return the currently reading story (simulates an api call)
  Future<List<Story>> fetchCurrentlyReading() async {
    final String response =
        await rootBundle.loadString('assets/data/currentlyReading.json');
    final data = await json.decode(response);

    List<Story> stories = [];

    for (var i = 0; i < data.length; i++) {
      stories.add(Story(
        title: data[i]['title'],
        coverUrl: data[i]['coverUrl'],
        textContent: data[i]['textContent'].cast<String>(),
        imageContent: data[i]['imageContent'].cast<String>(),
        currentPage: data[i]['currentPage'],
        isLiked: data[i]['isLiked'],
        id: data[i]['id'])
      );
    }
    return stories;
  }

  Future<List<Story>> fetchLikedStories() async {
    //await Future.delayed(const Duration(seconds: 5));
    final String response = await rootBundle.loadString('assets/data/stories.json');
    final data = await json.decode(response);

    List<Story> stories = [];

    //add a new story object to the list of stories for each story in the json file
    for (var i = 0; i < data.length; i++) {
      if (data[i]['isLiked'] == true) {
        stories.add(
          Story(
            title: data[i]['title'],
            coverUrl: data[i]['coverUrl'],
            textContent: data[i]['textContent'].cast<String>(),
            imageContent: data[i]['imageContent'].cast<String>(),
            currentPage: data[i]['currentPage'],
            isLiked: data[i]['isLiked'],
            id: data[i]['id']
          )
        );
      }
    }

    return stories;
  }

  Future<bool> updateLikeStatus(bool newLike, int storyID, int userID) async {
    //set the like status to the new one where the story ID and userID match

    //TODO: make a service call to do this!

    return false;
  }
}
