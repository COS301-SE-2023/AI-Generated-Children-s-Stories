import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'navbar.dart';
import 'myHeader.dart';

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  final List<String> _imageList = [
    'assets/storyPreviews/andy-the-ant.png',
    'assets/storyPreviews/benny-the-bear.png',
    'assets/storyPreviews/honey-the-kitty.png',
  ];

  final List<String> _captions = [
    'Andy the Ant',
    'Benny the Bear',
    'Honey the Kitty'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 243, 233),
      body: SafeArea(
        child: Column(children: [

          //the header
          const MyHeader(message: 'Story List'),

          //the story list 
          Expanded(
          child: ListView.builder(
            itemCount: _imageList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  //padding
                  const SizedBox(height: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Column(
                      children: [
                        Image.asset(
                          _imageList[index],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 35,
                          //rgb(84, 34, 9)
                          color: Color.fromARGB(255, 84, 34, 9),
                          fontFamily: 'NotoSerif'),
                      child: Text(_captions[index]),
                    ),
                  ),

                  const SizedBox(height: 5),

                  //progress bar with round corners

                  const Stack(children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 30,
                        //change width of cliprect
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 254, 141, 41)),
                          ),
                        ),
                      ),
                    ),

                    //center the
                    Center(
                      child: Text(
                        "50%",
                        style: TextStyle(
                            //rgb(0, 197, 61)
                            color: Color.fromARGB(255, 84, 34, 9),
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            fontFamily: 'NotoSerif'),
                      ),
                    ),
                  ]),

                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Image.asset('assets/images/viewButton.png'),
                    ),
                  ),
                  //image button
                ],
              );
            }),
      ),
        ],)
        
      ),
      bottomNavigationBar: NavbarWidget(),
      
    );
  }
}

/*

child: Column(children: [
          MyHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
             _imageList.map((String imagePath) {
              int index = _imageList.indexOf(imagePath);
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        //small image
                        
                        
                       
                        SizedBox(
                          height: MediaQuery.of(context).size.width*1.1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  imagePath, 
                                  width: MediaQuery.of(context).size.width * 1.5, 
                                ),
                                Container(
                                  transform: Matrix4.translationValues(90.0, -290, 0.0),
                                  child: Image.asset(
                                    'images/heart-filled.png',
                                    width: 30
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(0, -320, 0.0),
                                  child: const Text(
                                    'Like this story?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        Container(
                          transform: Matrix4.translationValues(0.0, -130.0, 0.0),
                          child:
                           DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 35,
                              //rgb(84, 34, 9)
                              color: Color.fromARGB(255, 84, 34, 9),
                              fontFamily: 'NotoSerif'
                          ),
                          child: Text(
                            _captions[index]
                          ),
                        ),

                        
                        ),
                        //title text 
                       Stack(
                          alignment: Alignment.center,
                          children: [
                            //progress bar with round corners 
                            SizedBox(
                              width: 300,
                              height: 30,
                              child: Container(
                                transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                                child: const ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  child: LinearProgressIndicator(
                                    value: 0.5,
                                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255,254, 141, 41)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0, -120, 0),
                              child: const Text(
                                "50%",
                                style: TextStyle(
                                  //rgb(0, 197, 61)
                                  color: Color.fromARGB(255, 84, 34, 9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  fontFamily: 'NotoSerif'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
          
                  );
                },
              );
            }).toList(),
            ),
          )
        ])
      ), 

*/
