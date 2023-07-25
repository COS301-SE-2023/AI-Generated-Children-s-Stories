import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// This class represents...

class BookWithProgress extends StatefulWidget {
  final String imagePath;
  final int id;
  final String title;
  final int currentPage;
  final int totalPages;

  // ignore: use_key_in_widget_constructors
  const BookWithProgress( {
    required this.title,
    required this.imagePath,
    required this.id,
    required this.currentPage,
    required this.totalPages
  });

  @override
  State<BookWithProgress> createState() => _BookWithProgressState();
}

class _BookWithProgressState extends State<BookWithProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: 300,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              color: Color(0xFF542209),
              fontFamily: 'NotoSerif'
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(64, 0, 64, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD3D3D3),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            barRadius: const Radius.circular(20),
            backgroundColor: const Color(0xFFFFFFFF),
            animation: true,
            lineHeight: 35.0,
            animationDuration: 1000,
            percent: widget.currentPage / widget.totalPages,
            center: Text(
        '${(widget.currentPage / widget.totalPages * 100).round()}%',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF542209),
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: 'Poppins'
        ),
      ),
            progressColor: Color(0xFFFE8D29),
          ),
        ),
        // ProgressBar(
        //   currentPages: widget.currentPage,
        //   totalPages: widget.totalPages,
        // ),
        GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/insideAStory', arguments: widget.id);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFE8D29),
                        borderRadius: BorderRadius.circular (25),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF84370F),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0,6),
                          )
                        ]
                      ),
                      child: const Center(
                        child: Text(
                          'VIEW',
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
      ]
    );
      //               ),
      //             ]),
      //             //story title
      //             Row(children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(
      //                   widget.title,
      //                   textAlign: TextAlign.center,
      //                   style: const TextStyle(
      //                       fontSize: 27,
      //                       //rgb(84, 34, 9)
      //                       color: Color.fromARGB(255, 84, 34, 9),
      //                       fontFamily: 'NotoSerif'),
      //                 ),
      //               ),
      //             ]),
      //             Row(
      //               children: [
      //                 ProgressBar(
      //                   currentPages: widget.currentPage,
      //                   totalPages: widget.totalPages,
      //                 )
      //               ],
      //             ),
      //             //prevent overflow
      //             Row(
      //                 children: [
      //                   //image button
      //                   ImageButton(
      //                     imagePath: 'assets/images/viewButton.png',
      //                     route: '/insideAStory',
      //                     id: widget.id,
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       )),
      // ],
  }
}
