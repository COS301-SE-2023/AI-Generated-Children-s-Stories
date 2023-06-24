import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        color: Colors.white,
      ),
      child: Row(
        //add a border
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Image.asset('assets/images/Books.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.pushNamed(context, '/storyList');
            },
          ),
          IconButton(
            icon: Image.asset('assets/images/Home.png'),
            iconSize: 50,
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: Image.asset('assets/images/Liked.png'),
            iconSize: 50,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
