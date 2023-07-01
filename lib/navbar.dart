import 'package:flutter/material.dart';

/// This class represents the navbar widget.
/// The UI contains three icons.
/// The first icon takes the user to the story list page.
/// The second icon takes the user to the home page.
/// The third icon takes the user to the liked page.
/// The navbar is displayed at the bottom of the screen.

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //round the corners
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        color: Colors.white,
      ),

      //row of three icons

      child: Row(
        //add a border
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: IconButton(
              key: const Key("StoryListNav"),
              icon: Image.asset('assets/images/Books.png'),
              iconSize: 50,
              onPressed: () {
                Navigator.pushNamed(context, '/storyList');
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Image.asset('assets/images/Home.png'),
              iconSize: 50,
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Image.asset('assets/images/Liked.png'),
              iconSize: 50,
              onPressed: () {
                Navigator.pushNamed(context, '/storyLiked');
              },
            ),
          )
        ],
      ),
    );
  }
}
