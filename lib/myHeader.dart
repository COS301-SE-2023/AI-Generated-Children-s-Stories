import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  const MyHeader({super.key});

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/Wave.png'),
            ),
          ),
        ),
      ],),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
            child: Transform.rotate(
              angle: -0.2, 
              child: Image.asset(
                'assets/images/MascotWinking.png',
                width: MediaQuery.of(context).size.width*0.15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: 
                const Text(
                'Here\'s a new book!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(right: 5), 
              child:  Image.asset(
                'assets/images/Profile.png',
                width:  MediaQuery.of(context).size.width*0.2,
              ),
            )
          )
          
        ]
      ),
    ]);
  }
}

/*
Row(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/Wave.png'),
                  ),
                ),
              ),
            ],),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                  child: Transform.rotate(
                    angle: -0.2, 
                    child: Image.asset(
                      'assets/images/MascotWinking.png',
                      width: MediaQuery.of(context).size.width*0.15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: 
                      const Text(
                      'Here\'s a new book!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5), 
                    child:  Image.asset(
                      'assets/images/Profile.png',
                      width:  MediaQuery.of(context).size.width*0.2,
                    ),
                  )
                )
                
              ]
            ),
*/