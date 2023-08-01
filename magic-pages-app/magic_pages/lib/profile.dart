import 'package:flutter/material.dart';
import 'package:magic_pages/wave_widget.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'button_widget.dart';

/// This class represents the profile page.
/// The UI contains a header and a button to log out.
/// The button is used to log out the user.
/// The header is used to show the user which page they are on.
/// The navbar is used to navigate to other pages.

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //change notifier

  //set story to empty story
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              WaveHeaderWidget(),
              Column(
                children: [
                  Column(
                    children: [
                      MyHeader(
                        message: 'Profile',
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWidget(destination: '/signup', message: 'LOGOUT',)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavbarWidget(active: 3),
    );
  }
}
