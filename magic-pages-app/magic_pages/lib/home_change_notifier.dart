import 'package:flutter/material.dart';
import 'get_stories_service.dart';
import 'story.dart';

/// This class represents the change notifier for the home page.
/// It uses the service to fetch the currently reading story.
/// It contains the currently reading story and the loading state.

class HomeChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;

  HomeChangeNotifier(this._getStoriesService);

  //initialise the currently reading story
  List<Story> _stories = [];

  List<Story> get currentlyReadingStory => _stories;

  //the loading state is used to show the loading symbol
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isNewBook => _stories.isEmpty;

  //fetch the currently reading story
  //this will be displayed on the home screen
  Future<void> fetchCurrentlyReading(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _stories = await _getStoriesService.fetchCurrentlyReading(context);
    print("Currently reading: ");
    print(_stories);
    _isLoading = false;
    notifyListeners();
  }
}
