import 'package:flutter/material.dart';
import 'package:magic_pages/end_of_story_change_notifier.dart';
import 'package:magic_pages/story.dart';
import 'package:magic_pages/get_stories_service.dart';

class EndOfStory extends StatefulWidget {
  const EndOfStory({required this.story});

  final Story story;

  @override
  State<EndOfStory> createState() => _EndOfStoryState();
}

class _EndOfStoryState extends State<EndOfStory> {
  //make a call to the api to get the story info
  final EndOfStoryChangeNotifier _endOfStoryChangeNotifier =
      EndOfStoryChangeNotifier(GetStoriesService());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
