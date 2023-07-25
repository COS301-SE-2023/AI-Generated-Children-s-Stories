package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.net.URISyntaxException;

import static org.junit.jupiter.api.Assertions.*;

class ImageGenerationTest {

    @Test
    void extractImageUrl() {
        String testResponseNull = "[{\"content\": \"(Waiting to start)\"}]";

        // should return null...
        try {
            ImageGeneration imageGeneration = new ImageGeneration(new APICalls());

            // null case
            String result = imageGeneration.extractImageUrl(testResponseNull);
            Assertions.assertEquals(result, null);

        } catch (URISyntaxException e) {
            fail("Exception thrown: " + e.getMessage());
        }
    }

    @Test
    void extractMessageID() {
        String testResponseBody = "[{\"id\":\"12345\",\"content\":\"I am a message!\"}]";

        try {
            ImageGeneration imageGeneration = new ImageGeneration(new APICalls());
            String actual = imageGeneration.extractMessageID(testResponseBody);

            Assertions.assertEquals("12345", actual);
        } catch (URISyntaxException e) {
            fail("Exception thrown: " + e.getMessage());
        }

    }

    //Offline test (not automated, requires API key)
    //uncomment in demo
    @Test
    void generateImage() {

        /*try {
            JsonProcessor jsonProcessor = new JsonProcessor();
            APICalls apiCalls = new APICalls(jsonProcessor, "configReal.json");
            ImageGeneration imageGeneration = new ImageGeneration(apiCalls);

            String url = imageGeneration.generateImage("A green spider");
            System.out.println(url);

            boolean isAnImage = url.contains(".png");

            assertEquals(isAnImage, true);

        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }*/
    }
}