import 'package:flutter/material.dart';

/// This class represents the navbar widget.
/// The UI contains three icons.
/// The first icon takes the user to the story list page.
/// The second icon takes the user to the home page.
/// The third icon takes the user to the liked page.
/// The navbar is displayed at the bottom of the screen.

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key, this.active=1});
  
  final int active;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      //round the corners
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        border: Border(
          top: BorderSide(
            color: Color(0xFFD3D3D3),
            width: 2,
          ),
          left: BorderSide(
            color: Color(0xFFD3D3D3),
            width: 1,
          ),
          right: BorderSide(
            color: Color(0xFFD3D3D3),
            width: 1,
          ),
          bottom: BorderSide(
            color: Color(0xFFD3D3D3),
            width: 0.01,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/storyList');
              },
              child: Column(
                children: [
                  Image.asset(
                    widget.active == 0 ? 'assets/images/nav-icons/books.webp' : 'assets/images/nav-icons/books-outline.webp',
                    width: 42,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Books',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ]
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Column(
                children: [
                  Image.asset(
                    widget.active == 1 ? 'assets/images/nav-icons/home.webp' : 'assets/images/nav-icons/home-outline.webp',
                    width: 42,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ]
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/storyLiked');
              },
              child: Column(
                children: [
                  Image.asset(
                    widget.active == 2 ? 'assets/images/nav-icons/liked.webp' : 'assets/images/nav-icons/liked-outline.webp',
                    width: 42,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Liked',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ]
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/storyLiked');
              },
              child: Column(
                children: [
                  Image.asset(
                    widget.active == 3 ? 'assets/images/nav-icons/download.webp' : 'assets/images/nav-icons/download-outline.webp',
                    width: 42,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Downloads',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
