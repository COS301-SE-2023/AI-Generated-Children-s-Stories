import 'get_stories_service.dart';
import 'package:flutter/material.dart';
import 'story.dart';

/// This class represents the change notifier for the story list.
/// It uses the service to fecth the stories.
/// It contains the list of stories and the loading state.
/// The loading state is used to show the loading symbol.
/// The list of stories is used to display the list of stories to the user.
/// The list of stories is used by the story list class.

class StoryListChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;
  StoryListChangeNotifier(this._getStoriesService);

  //initilise the list of stories
  List<Story> _stories = [];

  //get the list of stories
  List<Story> get stories => _stories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// fetch the list of stories
  /// this function is called when the user opens the story list page
  /// @return the list of stories
  Future<void> fetchCurrentlyReadingStories(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _stories = await _getStoriesService.fetchCurrentlyReading(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllStories(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _stories = await _getStoriesService.fetchAllStories(context);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLikedStories(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _stories = await _getStoriesService.fetchLikedStories(context);
    _isLoading = false;
    notifyListeners();
  }
}
