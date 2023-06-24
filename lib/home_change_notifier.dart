import 'package:flutter/material.dart';
import 'get_stories_service.dart';
import 'story.dart';

class HomeChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;

  HomeChangeNotifier(this._getStoriesService);

  Story _story = Story(
    title: '',
    coverUrl: '',
    textContent: [],
    imageContent: [],
    currentPage: 0,
  );

  Story get currentlyReadingStory => _story;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isNewBook => _story.currentPage == 0;

  Future<void> fetchCurrentlyReading() async {
    _isLoading = true;
    notifyListeners();
    _story = await _getStoriesService.fetchCurrrentlyReading();
    _isLoading = false;
    notifyListeners();
  }
}
