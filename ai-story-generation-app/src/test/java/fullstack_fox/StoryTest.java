package fullstack_fox;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class StoryTest {

    @Test
    void addPage() {
        Story story = new Story("Title", "tailer");
        story.addPage(new Page("content", "image"));

        assertEquals(story.pages.size(), 1);
    }

    @Test
    void printStory() {
        Story story = new Story("Title", "tailer");
        story.addPage(new Page("content", "image"));
        story.printStory();
    }
}