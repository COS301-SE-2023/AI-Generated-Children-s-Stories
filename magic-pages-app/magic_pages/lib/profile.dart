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
  bool isBackPressed = false;
  bool isNextPressed = false;
  bool isHomePressed = false;
  //change notifier

  //set story to empty story
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              const WaveHeaderWidget(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyHeader(
                    message: 'Logout',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          image: const AssetImage('assets/images/sad-fox.png'),
                          height: MediaQuery.of(context).size.height*0.4,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(64, 8, 64, 32),
                        child: Text(
                          'Are you sure you want to leave?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: const ButtonWidget(
                            message: 'NO',
                            destination: '/home',
                            color: 'grey',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: const ButtonWidget(
                            message: 'YES',
                            destination: '/splash',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavbarWidget(active: 4),
    );
  }
}
