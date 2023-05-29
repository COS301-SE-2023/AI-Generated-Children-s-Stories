import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myHeader.dart';

class InsideStory extends StatefulWidget {
  InsideStory({
    super.key
  });

  List<String> messages = [
    "Well done!", 
    "Almost there!",
    "Way to go!"
  ];

  @override
  State<InsideStory> createState() => _InsideStoryState();
}

class _InsideStoryState extends State<InsideStory> {

  int messageIndex = 0; 

  void next() {
    setState(() {
      messageIndex = Random().nextInt(widget.messages.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageState(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 243, 233),
        body: SafeArea(
          //back button
          child: Column(
            children: [
              Row(
                children: [
                  MyHeader(message: widget.messages[messageIndex])
                ]
              ),
              Row(children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { 
                    next();
                  },
                  child: Text('TextButton'),
                )
                
              ],)
            ]
          )
        )
      )
    );
  }
}

class PageState extends ChangeNotifier {

}