import 'package:flutter/material.dart';

import 'navbar.dart';
import 'myHeader.dart';

import 'image_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
        //back button
        child: Column(
          children: [
            const MyHeader(message: 'Here\'s a new book!',),
            //padding 
            const SizedBox(height: 50),
            Row(
              children:[
                //image with rounded corners 
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/storyPreviews/andy-the-ant.png'),
                      ),
                    ),
                  ),
                ),
              ]             
            ), 
            Row(children: [
              //image caption
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: const Text(
                    'Andy the Ant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      //hex color 
                      color: Color.fromARGB(255, 84, 34, 9),
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ],), 
            const Row(children: [
              //image button 
              ImageButton(
                imagePath: 'assets/images/viewButton.png',
                route: '/storyPage',
              )
            ],),     
          ],       
        ),
      ), 
      bottomNavigationBar: NavbarWidget(),
    );
  }
}