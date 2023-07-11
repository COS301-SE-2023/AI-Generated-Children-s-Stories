package fullstack_fox;

import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class StoryGenerationTest {

    @Test
    public void extractContent() {
        String inStoryNull = "{\"choices\":[{\"finish_reason\": \"I am a finish reason\", \"message\": {\"content\": \"I am content\"}}]}";
        String inStoryContent = "{\"choices\":[{\"finish_reason\": \"stop\", \"message\": {\"content\": \"I am content\"}}]}";

        //should return null
        try {
            StoryGeneration gen = new StoryGeneration(new APICalls("configTest.json"));

            String content = gen.extractContent(inStoryNull);
            assertNull(content);

            content = gen.extractContent(inStoryContent);
            assertEquals(content, "I am content");

        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

    @Test
    void finish_reason() {
        String inStory = "{\"choices\":[{\"finish_reason\": \"I am a finish reason\", \"content\": \"I am content\"}]}";

        try {
            StoryGeneration gen = new StoryGeneration(new APICalls("configTest.json"));

            String finishReason = gen.finish_reason(inStory);

            assertEquals(finishReason, "I am a finish reason");

        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

    @Test
    void splitParagraphs() {
        String paras = "para1\npara2\npara3";

        try {
            StoryGeneration gen = new StoryGeneration(new APICalls("configTest.json"));

            ArrayList<String> paragraphs = gen.splitParagraphs(paras);

            assertEquals(paragraphs.get(0), "para1");
            assertEquals(paragraphs.get(1), "para2");
            assertEquals(paragraphs.get(2), "para3");

        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }


    @Test
    void splitNumberedList() {
        String list = "1. Hello there\n2. My Child\n3.Good to see you";

        try {
            StoryGeneration gen = new StoryGeneration(new APICalls("configTest.json"));

            List<String> paragraphs = gen.splitNumberedList(list);

            System.out.println(paragraphs);

            assertEquals("Hello there", paragraphs.get(0));
            assertEquals("My Child", paragraphs.get(1));
            assertEquals("Good to see you", paragraphs.get(2));

        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

}