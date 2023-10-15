import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_pages/button_widget.dart';
import 'package:magic_pages/wave_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart';
import 'navbar.dart';
import 'my_header.dart';
import 'package:http/http.dart' as http;

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
  bool isPressed = false;
  //change notifier

  //set story to empty story
  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    //make an api call to reset the token

    const storage = FlutterSecureStorage();
    String? checkId = await storage.read(key: 'id');

    if (checkId != null) {


      final url = Uri.parse(
          "http://${Globals.ipAddress}/logout");

      print(url);

      try {
        final response = await http.post(
            url,
            headers: {'content-type': 'application/json'},
            body: checkId
        );

        if (response.statusCode == 200) {
          if (context.mounted) {

            await storage.delete(key: 'id');
            await storage.delete(key: 'apiKey');

            Navigator.pushNamed(context, '/splash');
          }
        } else {
          String message =
              'Error logging out, status code: ${response.statusCode}';
          if (context.mounted) {
            Globals.showSnackbarMessage(
                message, context);
          }
        }
      } catch (e) {
        String message = 'Error logging out, message: $e';
        if (context.mounted) {
          Globals.showSnackbarMessage(
              message, context);
        }
      }
    } else {
      String message = 'Failed to log out';
      if (context.mounted) {
        Globals.showSnackbarMessage(message, context);
      }
    }
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
                  Column(
                    children: [
                      Container(
                        height: 88,
                        margin: const EdgeInsets.only(top: 50.0),
                        child: Center(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                   onTap: () async {
                                     if (!await launchUrl(Uri.parse('https://fullstackfox.co.za/help'))) {
                                       throw Exception('Could not launch help page');
                                     }
                                   },
                                   child: Container(
                                     height: 50,
                                     width: 100,
                                     margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                     decoration: BoxDecoration(
                                       color: const Color(0xFFFDFDFD),
                                       borderRadius: BorderRadius.circular (25),
                                       border: Border.all(
                                         color: const Color(0xFFD3D3D3),
                                         width: 2,
                                       ),
                                     ),
                                     child: const Center(
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Image(
                                             image: AssetImage('assets/images/nav-icons/help.webp'),
                                             width: 25,
                                           ),
                                           SizedBox(width: 8),
                                           Text(
                                             'HELP',
                                             style: TextStyle(
                                               fontSize: 18,
                                               fontFamily: 'Poppins',
                                               fontWeight: FontWeight.w500,
                                               color: Color(0xFFFE8D29),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   margin: const EdgeInsets.only(right: 16),
                                   child: const Image(
                                     image: AssetImage('assets/images/nav-icons/signout.webp'),
                                     width: 40,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height-(94+138+MediaQuery.of(context).padding.top+MediaQuery.of(context).padding.bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: const AssetImage('assets/images/sad-fox.png'),
                                  height: MediaQuery.of(context).size.height*0.4,
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(64, 16, 64, 32),
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
                                    child: GestureDetector(
                                      onTapUp: (val) {
                                        setState(() {
                                          isPressed = false;
                                        });
                                        logout();
                                      },
                                      onTapDown: (val) {
                                        setState(() {
                                          isPressed = true;
                                        });
                                      },
                                      onTapCancel: () {
                                        setState(() {
                                          isPressed = false;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 50,
                                        width: double.infinity,
                                        margin: isPressed ? const EdgeInsets.fromLTRB(16, 6, 16, 0) : const EdgeInsets.fromLTRB(16, 0, 16, 6),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFE8D29),
                                            borderRadius: BorderRadius.circular (25),
                                            boxShadow: isPressed ? null : [
                                              const BoxShadow(
                                                color: Color(0xFF84370F),
                                                spreadRadius: 0,
                                                blurRadius: 0,
                                                offset: Offset(0,6),
                                              )
                                            ]
                                        ),
                                        duration: const Duration(milliseconds: 75),
                                        child: const Center(
                                          child: Text(
                                            'YES',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFDFDFD),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
      bottomNavigationBar: const NavbarWidget(active: 3),
    );
  }
}
