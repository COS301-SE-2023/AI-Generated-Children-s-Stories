import 'package:flutter/material.dart';
import 'get_stories_service.dart';
import 'story.dart';

/// This class represents the change notifier for the home page.
/// It uses the service to fecth the currently reading story.
/// It contains the currently reading story and the loading state.

class HomeChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;

  HomeChangeNotifier(this._getStoriesService);

  //initilise the currently reading story
  Story _story = Story(
      title: '',
      coverUrl: '',
      textContent: [],
      imageContent: [],
      currentPage: 0,
      id: 0);

  Story get currentlyReadingStory => _story;

  //the loading state is used to show the loading symbol
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isNewBook => _story.currentPage == 0;

  //fetch the currently reading story
  //this will be displayed on the home screen
  Future<void> fetchCurrentlyReading() async {
    _isLoading = true;
    notifyListeners();
    _story = await _getStoriesService.fetchCurrrentlyReading();
    _isLoading = false;
    notifyListeners();
  }
}
