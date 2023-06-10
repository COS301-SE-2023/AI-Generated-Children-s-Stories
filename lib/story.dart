class Story {
  final String title;
  final String coverUrl;
  final List<String> textContent;
  final List<String> imageContent;
  int index = 0; 

  Story({
    required this.title,
    required this.coverUrl,
    required this.textContent,
    required this.imageContent,
  }) {}

  //parse in a json object and return a Story object
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['title'],
      coverUrl: json['coverUrl'],
      textContent: json['textContent'],
      imageContent: json['imageContent'],
    );
  }

  Object getNext() {
    if (index < textContent.length - 1) {
      index = index + 1;
    }

    if (index == textContent.length - 1) {
      return {
        textContent[index], 
        imageContent[index], 
        true //is last item
      };
    } else {
      return {
        textContent[index], 
        imageContent[index], 
        false //is last item
      };
    }
  }

  Object getPrev() {
    if (index > 0) {
      index = index - 1;
    }

    if (index == textContent.length - 1) {
      return {
        textContent[index], 
        imageContent[index], 
        true //is last item
      };
    } else {
      return {
        textContent[index], 
        imageContent[index], 
        false //is last item
      };
    }
  }

}
    
    
    // title: `Andy the Ant ${i}`,
//             cover_url: 'assets/stories/AndyTheAnt/cover.jpg',
//             textContent: [
//                 {
//                     "Once upon a time, there was a curious ant named Andy. He lived in a cozy anthill under a big oak tree. Andy loved exploring with his ant friends.",
//                     "One sunny morning, Andy found a shiny golden key. He didn't know where it came from or what it unloc, ked, but he was determined to find out.",
//                     "Carrying the key, Andy went on an exciting journey through tall grass, up branches, and across a tiny stream. Finally, he discovered a huge rock with door.",
//                     "Andy turned the key in the keyhole, and the door opened, revealing a hidden chamber. Inside, there was delicious food."
//                 }
//             ], 
//             imageContent: [
//                 "assets/images/stories/AndyTheAnt/img1.jpg",
//                 "assets/images/stories/AndyTheAnt/img2.jpg",
//                 "assets/images/stories/AndyTheAnt/img3.jpg",
//                 "assets/images/stories/AndyTheAnt/img4.jpg"
//             ]

