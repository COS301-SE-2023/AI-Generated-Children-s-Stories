package fullstack_fox;

public class Page {
    String content;
    String imageUrl;

    public Page(String inContent, String inImageUrl) {
        content = inContent;
        imageUrl = inImageUrl;
    }

    public String getContent() {
        return content;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void print(){
        System.out.println(imageUrl);
        System.out.println(content);
    }
}
