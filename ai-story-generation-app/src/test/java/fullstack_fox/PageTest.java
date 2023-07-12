package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PageTest {

    @Test
    void getContent() {
        Page page = new Page("content", "img_url");
        Assertions.assertEquals(page.getContent(), "content");
    }

    @Test
    void getImageUrl() {
        Page page = new Page("content", "img_url");
        Assertions.assertEquals(page.getImageUrl(), "img_url");
    }

    @Test
    void print() {
        Page page = new Page("content", "img_url");
        String printed = page.print();
        String expected = "----------\n" +
                "Image URL:\n" +
                "img_url\n" +
                "\n" +
                "Paragraph:\n" +
                "content\n" +
                "----------\n";
        Assertions.assertEquals(expected, printed);
    }
}