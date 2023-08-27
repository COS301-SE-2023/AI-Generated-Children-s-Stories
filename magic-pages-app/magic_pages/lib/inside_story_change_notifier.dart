
import 'package:flutter/cupertino.dart';
import 'package:magic_pages/get_stories_service.dart';
import 'package:magic_pages/story_page.dart';

class InsideStoryChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;
  InsideStoryChangeNotifier(this._getStoriesService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<StoryPage>> fetchPages(BuildContext context, storyId) async {
    _isLoading = true;
    notifyListeners();
    List<StoryPage> pages = await _getStoriesService.fetchPages(storyId, context);
    _isLoading = false;
    notifyListeners();
    return pages;
  }

}