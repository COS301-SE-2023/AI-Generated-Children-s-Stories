class Story {
  final String title;
  final String coverUrl;
  final List<String> textContent;
  final List<String> imageContent;
  final int currentPage;
  int index = 0;

  Story(
      {required this.title,
      required this.coverUrl,
      required this.textContent,
      required this.imageContent,
      required this.currentPage});

  String getTitle() {
    return title;
  }

  String getCoverUrl() {
    return coverUrl;
  }

  List<String> getTextContent() {
    return textContent;
  }

  List<String> getImageContent() {
    return imageContent;
  }

  int getCurrentPage() {
    return currentPage;
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
