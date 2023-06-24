import 'dart:convert';

import 'package:Magic_Pages/get_stories_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'story.dart';


class StoryListChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;

  StoryListChangeNotifier(this._getStoriesService);

  List<Story> _stories = [];

  List<Story> get stories => _stories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchStories() async {
    _isLoading = true;
    notifyListeners();
    _stories = await _getStoriesService.fetchStories();  
    _isLoading = false;  
    notifyListeners();
  }
}