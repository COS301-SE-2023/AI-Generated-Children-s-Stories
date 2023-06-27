import 'package:flutter/material.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'progress_bar.dart';
import 'image_button.dart';
import 'home_change_notifier.dart';
import 'get_stories_service.dart';
import 'story.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
        //back button
        child: Column(
          children : [
          const Column(
                    children: [
                      MyHeader(
                        message: 'Profile',
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFFE8D29)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
