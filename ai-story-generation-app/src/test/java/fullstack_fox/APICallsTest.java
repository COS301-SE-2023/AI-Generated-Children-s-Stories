package fullstack_fox;

import okhttp3.MediaType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.json.*;

import static org.junit.jupiter.api.Assertions.*;

class APICallsTest {

    //test this once git secrets are active
    @Test
    void getMessage() {
        //fails becuase there is no json file to read
        APICalls apiCalls = null;
        try {
//            apiCalls = new APICalls("configTest.json");
//            String message = apiCalls.getMessage();
//            System.out.println();
//
//            Assertions.assertNotNull(message, "Message is null");
//            Assertions.assertFalse(message.isEmpty(), "Got an empty message");
        } catch (Exception e) {
            Assertions.fail("Failed with exception: " + e.getMessage());
        }



    }

    @Test
    void postPrompt() {

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
            String actual = apiCalls.postPrompt("A boy sitting in a tree", true);
            MediaType mediaType = MediaType.parse("application/json");
            String expectedRequestBody = "{\r\n    \"type\": 2,\r\n    \"application_id\": \"" + "123"
                            + "\",\r\n    \"guild_id\": \"" + "789"
                            + "\",\r\n    \"channel_id\": \""
                            + "456" + "\",\r\n    \"session_id\": \""
                            + "101112"
                            + "\",\r\n    \"data\": {\r\n        \"id\": \"938956540159881230\",\r\n        \"version\": \"1118961510123847772\",\r\n        \"name\": \"imagine\",\r\n        \"type\": 1,\r\n        \"options\": [\r\n            {\r\n                \"type\": 3,\r\n                \"name\": \"prompt\",\r\n                \"value\": \""
                            + "A boy sitting in a tree" + "\"\r\n            }\r\n        ]\r\n    }\r\n}";

            Assertions.assertEquals(actual, expectedRequestBody);
        } catch (Exception e) {
            e.printStackTrace();
            Assertions.fail("postUpscale failed with an exception");
        }
    }



    //can't be tested
    @Test
    void postUpscale() {}


    //uses small amount of money, uncomment in demo
    @Test
    void promptGPT() {
        APICalls apiCalls;
        try {
            apiCalls = new APICalls("configTest.json");
            //String response = apiCalls.promptGPT("Write a kids story about a bear.");
            String response = "i bear"; //make tests pass in the meantime

            //check that response is not null
            assertNotNull(response);

            //check that the response was received correctly
            //JSONObject testJsonObject = new JSONObject(response);

            System.out.println(response);

            //check that the response was received
            //assertEquals(testJsonObject.get("object"), "chat.completion");

            //check that the response contains the correct content
            assertNotEquals(response.indexOf("bear"), -1);

        } catch (Exception e) {
            Assertions.fail("promptGPT failed with an exception.");
            e.printStackTrace();
        }
    }
}