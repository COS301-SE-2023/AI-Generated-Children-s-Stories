import 'package:flutter/material.dart';
import 'package:magic_pages/end_of_story_change_notifier.dart';
import 'package:magic_pages/story.dart';
import 'package:magic_pages/get_stories_service.dart';
import 'package:magic_pages/progress_bar.dart';
import 'package:magic_pages/navbar.dart';

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
  void initState() {
    super.initState();
  }

  void toggleStoryLiked() async {
    await _endOfStoryChangeNotifier.updateLikeStatus(
        !widget.story.getIsLiked(), widget.story.id, 1);
    setState(() {
      widget.story.setIsLiked(!widget.story.getIsLiked());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/Wave.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //header row
          Row(children: [
            Expanded(
              flex: 1,
              child: Transform.rotate(
                angle: -0.2,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                  child: Image.asset(
                    'assets/images/MascotWinking.png',
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Did you like this book?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: widget.story.isliked
                      ? IconButton(
                          icon: Image.asset('assets/images/heart-filled.png'),
                          iconSize: 50,
                          onPressed: () {
                            //TODO: unlike the story

                            widget.story.setIsLiked(false);
                            setState(() {});
                          },
                        )
                      : IconButton(
                          icon: Image.asset('assets/images/heart-empty.png'),
                          iconSize: 50,
                          onPressed: () {
                            //TODO: like the story
                            widget.story.setIsLiked(true);
                            setState(() {});
                          })),
            )
          ]),
          Column(
            children: [
              Row(
                children: [
                  //expanded with text
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Well done! You finished the book!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(
                        "assets/images/MascotSitting.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  )
                ],
              ),
              const Row(children: [
                Expanded(
                    child: ProgressBar(
                  currentPages: 10,
                  totalPages: 10,
                ))
              ]),
            ],
          )
        ],
      )),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
