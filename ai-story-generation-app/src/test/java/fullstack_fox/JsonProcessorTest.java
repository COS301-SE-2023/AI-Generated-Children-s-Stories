package fullstack_fox;

import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.*;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;


class JsonProcessorTest {

    // @Test
    // void readJson() {
    //     JSONObject testObj = new JSONObject();
    //     testObj.put("applicationID", "1");
    //     testObj.put("channelID", "2");
    //     testObj.put("guildID", "3");
    //     testObj.put("sessionID", "4");
    //     testObj.put("botAuthorization", "5");
    //     testObj.put("userAuthorization", "6");
    //     testObj.put("chatGPTKey", "7");

    //     try {

    //         File f = new File("target/test-classes/fullstack_fox/resources/output.json");
    //         f.getParentFile().mkdirs();
    //         f.createNewFile();

    //         FileWriter fileWriter = new FileWriter("target/test-classes/fullstack_fox/resources/output.json");
    //         fileWriter.write(testObj.toString());
    //         fileWriter.close();

    //         //test the function
    //         JsonProcessor jsonProcessor = new JsonProcessor();

    //         ArrayList<String> readParameters = jsonProcessor.readJson("output.json");

    //         //todo: check that it read the right pararmeters


    //         //delete the dirs
    //         f.delete();
    //         f = new File("target/test-classes/fullstack_fox/resources");
    //         f.delete();


    //     }
    //     catch (IOException | URISyntaxException e) {
    //         e.printStackTrace();
    //     }
    // }

    @Test
    void writeStoryToJson() throws URISyntaxException, FileNotFoundException {
        Story story = new Story("Benny Boy", "trailer_url");
        story.addPage(new Page(
                "I am page content",
                "image_url"
        ));

        JsonProcessor processor = new JsonProcessor();
        processor.writeStoryToJson(story, "newStory.json");

        //read the json
        String str = "";

        //delete the json
        try {
            str = Files.readString(Path.of("newStory.json"));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        JSONObject object = new JSONObject(str);

        Assertions.assertEquals("trailer_url", object.get("trailer"));

        JSONObject page = object.getJSONArray("pages").getJSONObject(0);

        Assertions.assertEquals(page.get("image"), "image_url");
        Assertions.assertEquals(page.get("pageNumber"), 1);
        Assertions.assertEquals(page.get("text"), "I am page content");

        //delete the file
        File toDelete = new File("newStory.json");
        System.out.println(toDelete.delete());


    }
}