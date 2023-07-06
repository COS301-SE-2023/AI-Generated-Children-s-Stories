package fullstack_fox;

import org.junit.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.net.URISyntaxException;

import static org.junit.jupiter.api.Assertions.*;

class ImageGenerationTest {

    @Test
    void generateImage() {
    }

    @Test
    void imageGenDelay() {
    }

    /*
    public String extractImageUrl(String inResponseBody) {

        JSONArray jsonArray = new JSONArray(inResponseBody);
        String content = "";
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject messageObject = jsonArray.getJSONObject(i);
            content = messageObject.getString("content");
        }
        if (content.contains("(Waiting to start)")) {
            return null;
        }
        String url = "";
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            url = jsonObject.getJSONArray("attachments")
                    .getJSONObject(0)
                    .getString("url");
        }
        return url;
    }
     */
    @Test
    void extractImageUrl() {
        String testResponseNull = "[{\"content\": \"(Waiting to start)\"}]";

        //should return null...
        try {
            ImageGeneration imageGeneration = new ImageGeneration(new APICalls("configTest.json"));

            //null case
            String result = imageGeneration.extractImageUrl(testResponseNull);
            Assertions.assertEquals(result, null);

        } catch (URISyntaxException e) {
            fail("Exception thrown: " + e.getMessage());
        }
    }

    @Test
    void latestMessageID() {
    }

    @Test
    void extractMessageID() {
        String testResponseBody = "[{\"id\":\"12345\",\"content\":\"I am a message!\"}]";

        try {
            ImageGeneration imageGeneration = new ImageGeneration(new APICalls("configTest.json"));
            String actual = imageGeneration.extractMessageID(testResponseBody);

            Assertions.assertEquals("12345", actual);
        } catch (URISyntaxException e) {
            fail("Exception thrown: " + e.getMessage());
        }

    }
}