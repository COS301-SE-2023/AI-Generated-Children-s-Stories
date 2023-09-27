import 'package:flutter/material.dart';

/// This class represents the navbar widget.
/// The UI contains three icons.
/// The first icon takes the user to the story list page.
/// The second icon takes the user to the home page.
/// The third icon takes the user to the liked page.
/// The navbar is displayed at the bottom of the screen.

//todo: use ternary statements to determine which is active

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key, this.active = 1});

  final int active;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    Widget navigation;
    switch (widget.active) {
      case 0:
        navigation = Row(
          //add a border
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.asset(
                  widget.active == 0 ? 'assets/images/nav-icons/books.webp' : 'books-outline.webp',
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
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/home-outline.webp',
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
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/storyLiked');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/liked-outline.webp',
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
                ]),
              ),
            ),
          ],
        );
        break;
      case 1:
        navigation = Row(
          //add a border
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/storyList');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/books-outline.webp',
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
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.asset(
                  'assets/images/nav-icons/home.webp',
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
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/storyLiked');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/liked-outline.webp',
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
                ]),
              ),
            ),
          ],
        );
        break;
      case 2:
        navigation = Row(
          //add a border
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/storyList');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/books-outline.webp',
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
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Column(children: [
                  Image.asset(
                    'assets/images/nav-icons/home-outline.webp',
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
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.asset(
                  'assets/images/nav-icons/liked.webp',
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
              ]),
            ),
          ],
        );
        break;
      case 3:
        navigation = Row(
        //add a border
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/storyList');
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nav-icons/books-outline.webp',
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
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nav-icons/home-outline.webp',
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
                Navigator.pushReplacementNamed(context, '/storyLiked');
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nav-icons/liked-outline.webp',
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
        ],
      );
        break;
      default:
        throw UnimplementedError('no widget for $widget.active');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.

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
              width: 0,
            ),
          ),
          color: Colors.white,
        ),
        //row of three icons
        child: navigation);
  }
}
