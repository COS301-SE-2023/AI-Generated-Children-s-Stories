import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:magic_pages/story_page.dart';
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
        Uri.parse("http://${GlobalVariables.ipAddress}/library/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);

        for (var story in data) {
          Story newStory = Story(
              title: story['title'],
              trailer: story['trailer'],
              textContent:[],
              imageContent:[],
              currentPage: story['pageNo'],
              id: story['storyId'],
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

  Future<List<StoryPage>> fetchPages(int storyId, BuildContext context) async {

    List<StoryPage> pages = [];

    final url = Uri.parse("http://${GlobalVariables.ipAddress}/pages/${storyId}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var page in data) {
          pages.add(
            StoryPage(
                image: page['image'],
                text: page['text']
            )
          );
        }

      } else {
        if (context.mounted) {
          GlobalVariables.showSnackbarMessage(
              "Failed to get story: ${response.statusCode}", context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        GlobalVariables.showSnackbarMessage(
            "Failed to get story: $e", context);
      }
    }
    return pages;
  }

  Future<List<Story>> fetchFromUrl(String apiUlr, BuildContext context) async {
    List<Story> stories = [];

    //make an API call and pass in the id and token
    final url = Uri.parse(apiUlr);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var userStoryInfoEntity in data) {
          print("GETTING STORY");
          //create a book
          print(userStoryInfoEntity);

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

  //read the json file and return the currently reading story (simulates an api call)
  Future<List<Story>> fetchCurrentlyReading(BuildContext context) async {
    List<String> idToken = await GlobalVariables.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];
    if (context.mounted) {
      return fetchFromUrl(
          "http://${GlobalVariables.ipAddress}/userStoryInfo/random/$id",
          context);
    }
    throw "Context not mounted when fetching random story";
  }

  //todo: change to liked stories
  Future<List<Story>> fetchLikedStories(BuildContext context) async {
    List<String> idToken = await GlobalVariables.getIdAndToken();
    String id = idToken[0];
    String token = idToken[1];
    if (context.mounted) {
      return fetchFromUrl(
          "http://${GlobalVariables.ipAddress}/userStoryInfo/liked/$id",
          context);
    }
    throw "Context not mounted when fetching liked stories";
  }
}
