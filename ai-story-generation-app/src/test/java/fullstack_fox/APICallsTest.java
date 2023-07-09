package fullstack_fox;

import okhttp3.MediaType;
import okhttp3.RequestBody;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.json.*;

import static org.junit.jupiter.api.Assertions.*;

class APICallsTest {

    @Test
    void getMessage() {
        //fails becuase there is no json file to read
        APICalls apiCalls = null;
        try {
            apiCalls = new APICalls("configTest.json");
        } catch (Exception e) {
            e.printStackTrace();
            Assertions.fail("Failed with exception: " + e.getMessage());
        }

        String message = apiCalls.getMessage();

        Assertions.assertNotNull(message, "Message is null");
        Assertions.assertFalse(message.isEmpty(), "Got an empty message");

    }

    @Test
    void postPrompt() {
        // Provide test inputs
        String inImageURL = "https://example.com/image.jpg";
        String inMessageID = "123456789";

        // Create an instance of APICalls
        APICalls apiCalls;
        try {
            apiCalls = new APICalls("configTest.json");
        } catch (Exception e) {
            e.printStackTrace();
            Assertions.fail("Failed to initialize APICalls");
            return;
        }

        // Call the post prompt method
        try {
            String actual = apiCalls.postPrompt("A boy sitting in a tree");
            MediaType mediaType = MediaType.parse("application/json");
            String expectedRequestBody = "{\r\n    \"type\": 2,\r\n    \"application_id\": \"" + "936929561302675456"
                            + "\",\r\n    \"guild_id\": \"" + "1077576404675338321"
                            + "\",\r\n    \"channel_id\": \""
                            + "1109207920551416000" + "\",\r\n    \"session_id\": \""
                            + "0e3a6b201ad3f8e45eaffbd6f2830415"
                            + "\",\r\n    \"data\": {\r\n        \"id\": \"938956540159881230\",\r\n        \"version\": \"1118961510123847772\",\r\n        \"name\": \"imagine\",\r\n        \"type\": 1,\r\n        \"options\": [\r\n            {\r\n                \"type\": 3,\r\n                \"name\": \"prompt\",\r\n                \"value\": \""
                            + "A boy sitting in a tree" + "\"\r\n            }\r\n        ]\r\n    }\r\n}";

            Assertions.assertEquals(actual, expectedRequestBody);
        } catch (Exception e) {
            e.printStackTrace();
            Assertions.fail("postUpscale failed with an exception");
        }
    }



    @Test
    void postUpscale() {}

    @Test
    void promptGPT() {
        APICalls apiCalls;
        try {
            apiCalls = new APICalls("configTest.json");
            String response = apiCalls.promptGPT("Write a kids story about a bear.");

            //check that response is not null
            assertNotNull(response);

            //check that the response was received correctly
            JSONObject testJsonObject = new JSONObject(response);
            assertEquals(testJsonObject.get("object"), "chat.completion");
        } catch (Exception e) {
            Assertions.fail("promptGPT failed with an exception.");
            e.printStackTrace();
        }
    }
}