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

    public void print() {
        System.out.println("----------");
        System.out.println("Image URL:");
        System.out.println(imageUrl + "\n");
        System.out.println("Paragraph:");
        System.out.println(content);
        System.out.println("----------");
    }
}
