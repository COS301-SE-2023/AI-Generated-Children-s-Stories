import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_variables.dart';
import 'story.dart';
import 'package:http/http.dart' as http;

/// This class represents the service that gets the stories from the json file.
/// It contains the fetchStories function, which reads the json file and returns the stories.
/// It also contains the fetchCurrentlyReading function, which reads the json file and returns the currently reading story.
/// The fetchCurrentlyReading function is not used in the app.
/// The fetchCurrentlyReading function is used by the home page to display the currently reading book.
/// The fetchStories function is used in the StoryList class to display the list of stories to the user.

class GetStoriesService {
  //read the json file and return the stories (simulates an api call)
  //continue with integration tests

  Future<List<Story>> fetchAllStories(BuildContext context) async {
    List<String> idToken = await GlobalVariables.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];

    print(id);

    List<Story> stories = [];

    final url =
        Uri.parse("http://${GlobalVariables.ipAddress}/userStoryInfo/random/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var story in data) {
          Story newStory = Story(
              title: story['title'],
              trailer: story['trailer'],
              textContent:[],
              imageContent:[],
              currentPage: story['pageNo'],
              id: story['id'],
              isLiked: story['liked']
          );
          stories.add(newStory);
        }

      } else {
        if (context.mounted) {
          GlobalVariables.showSnackbarMessage(
              "Failed to get story: ${response.statusCode}", context);
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return stories;
  }

  //read the json file and return the currently reading story (simulates an api call)
  Future<List<Story>> fetchCurrentlyReading(BuildContext context) async {
    List<String> idToken = await GlobalVariables.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];

    List<Story> stories = [];

    //make an API call and pass in the id and token
    final url = Uri.parse("http://${GlobalVariables.ipAddress}/userStoryInfo/random/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var userStoryInfoEntity in data) {
          //create a book
          print(userStoryInfoEntity);

          print(userStoryInfoEntity['title']);
          print(userStoryInfoEntity['trailer']);
          print(userStoryInfoEntity['pageNo']);
          print(userStoryInfoEntity['storyId']);
          print(userStoryInfoEntity['liked']);

          print("trying to add");

          Story story = Story(
              title: userStoryInfoEntity['title'],
              trailer: userStoryInfoEntity['trailer'],
              textContent: [""],
              imageContent: [""],
              currentPage: userStoryInfoEntity['pageNo'],
              id: userStoryInfoEntity['storyId'],
              isLiked: userStoryInfoEntity['liked']
          );
          stories.add(story);
        }

        return stories;
      } else {
        if (context.mounted) {
          GlobalVariables.showSnackbarMessage(
              "Failed to get story: ${response.statusCode}", context);
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return stories;
  }

  Future<List<Story>> fetchLikedStories() async {
    //await Future.delayed(const Duration(seconds: 5));
    final String response =
        await rootBundle.loadString('assets/data/stories.json');
    final data = await json.decode(response);

    List<Story> stories = [];

    //add a new story object to the list of stories for each story in the json file
    for (var i = 0; i < data.length; i++) {
      if (data[i]['isLiked'] == true) {
        stories.add(Story(
            title: data[i]['title'],
            trailer: data[i]['coverUrl'],
            textContent: data[i]['textContent'].cast<String>(),
            imageContent: data[i]['imageContent'].cast<String>(),
            currentPage: data[i]['currentPage'],
            isLiked: data[i]['isLiked'],
            id: data[i]['id']));
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
