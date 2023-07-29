import 'package:flutter/material.dart';
import 'package:magic_pages/button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          key: Key('SplashPage'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/fox.png'),
                      width: 200,
                    ),
                    Text(
                      'Magic Pages',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'TitanOne',
                        color: Color(0xFFFE8D29),
                      ),
                    ),
                    Text(
                      'Learn to read with AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
              Button(text: 'GET STARTED', route: '/signup'),
            ],
          ),
        ),
      ),
    );
  }
}
