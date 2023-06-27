/// Story class to hold story data
/// It contains the title, cover url, text content, image content and current page.
/// The title is used to display the title of the story to the user.
/// The cover url is used to display the cover of the story to the user.
/// The text content is used to display the story text to the user.
/// The image content is used to display the image which corresponds to each piece of text to the user.

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

  //get the next page
  //if the current page is the last page, return the last page
  //else return the next page
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

  //get the previous page
  //if the current page is the first page, return the first page
  //else return the previous page
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
