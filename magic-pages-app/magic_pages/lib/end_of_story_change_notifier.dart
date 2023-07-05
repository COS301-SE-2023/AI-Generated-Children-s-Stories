import 'package:flutter/material.dart';
import 'get_stories_service.dart';

class EndOfStoryChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;

  EndOfStoryChangeNotifier(this._getStoriesService);

  //The end of story change notifier just needs
  //the name of the story, the like status,
  //and a way to update the like status in the backend
  //as well as the image URL

  Future<bool> updateLikeStatus(bool newLike, int storyID, int userID) async {
    return await _getStoriesService.updateLikeStatus(newLike, storyID, userID);
  }

  Future<void> markAsRead(int storyID, int userID) async {
    await _getStoriesService.markAsRead(storyID, userID);
  }
}
