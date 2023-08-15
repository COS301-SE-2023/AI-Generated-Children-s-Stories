package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class StoryTest {

    @Test
    void addPage() {
        Story story = new Story("Title", "Trailer");

        story.addPage(new Page("content1", "imageUrl1"));
        story.addPage(new Page("content2", "imageUrl2"));

        ArrayList<Page> pages = story.pages;

        Assertions.assertEquals(pages.get(0).content, "content1");
        Assertions.assertEquals(pages.get(1).content, "content2");
        Assertions.assertEquals(pages.get(0).imageUrl, "imageUrl1");
        Assertions.assertEquals(pages.get(1).imageUrl, "imageUrl2");
    }
}