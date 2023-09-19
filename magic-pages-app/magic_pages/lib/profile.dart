import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_pages/wave_widget.dart';
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
            Globals.showSnackbarMessage(
                'Logged out', context);

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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFE8D29)),
                          ),
                          onPressed: () async {
                            logout();
                          },
                          child: const Text('Log Out'),
                        ),
                      ],
                    ),
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
