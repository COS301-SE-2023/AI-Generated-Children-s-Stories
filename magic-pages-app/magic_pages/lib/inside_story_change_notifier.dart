
import 'package:flutter/cupertino.dart';
import 'package:magic_pages/get_stories_service.dart';
import 'package:magic_pages/story_page.dart';

class InsideStoryChangeNotifier extends ChangeNotifier {
  final GetStoriesService _getStoriesService;
  InsideStoryChangeNotifier(this._getStoriesService);

  List<StoryPage> _pages = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPages(BuildContext context, storyId) async {
    print("Getting inside story");
    _isLoading = true;
    notifyListeners();
    _pages = await _getStoriesService.fetchPages(storyId, context);
    _isLoading = false;
    notifyListeners();
    print("got inside story)");
  }

}