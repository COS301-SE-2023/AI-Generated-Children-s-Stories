package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PageTest {

    @Test
    void getContent() {
        Page page = new Page("content", "img_url");

        String content = page.getContent();

        Assertions.assertEquals(content, "content");
    }

    @Test
    void getImageUrl() {
        Page page = new Page("content", "img_url");

        String img_url = page.getImageUrl(); //s

        Assertions.assertEquals(img_url, "img_url");
    }
}