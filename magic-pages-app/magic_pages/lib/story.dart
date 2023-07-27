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
  final int id;
  bool isLiked = false;

  Story(
      {required this.title,
      required this.coverUrl,
      required this.textContent,
      required this.imageContent,
      required this.currentPage,
      required this.id, 
      required this.isLiked});

  /// get the liked status of the story
  /// @return the like status
  bool getIsLiked() {
    return isLiked;
  }

  /// set the like status of the story
  void setIsLiked(bool likeStatus) {
    isLiked = likeStatus;
  }

  /// get the id of the story
  /// @return the id of the story
  int getId() {
    return id;
  }

  /// get the title of the story
  /// @return the title of the story
  String getTitle() {
    return title;
  }

  /// get the cover url of the story
  /// @return the cover url of the story
  String getCoverUrl() {
    return coverUrl;
  }

  /// get the text content of the story
  /// @return the text content of the story
  List<String> getTextContent() {
    return textContent;
  }

  /// get the image content of the story
  /// @return the image content of the story
  List<String> getImageContent() {
    return imageContent;
  }

  /// get the current page of the story
  /// @return the current page of the story
  int getCurrentPage() {
    return currentPage;
  }

  /// get the next page
  /// if the current page is the last page, return the last page
  /// else return the next page
  /// @return the next page
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

  /// get the previous page
  /// if the current page is the first page, return the first page
  /// else return the previous page
  /// @return the previous page
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
