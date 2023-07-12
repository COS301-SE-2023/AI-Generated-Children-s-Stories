package fullstack_fox;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import org.json.*;

public class JsonProcessor {

    public JsonProcessor() {
    }

    public ArrayList<String> readJson(String inFName) throws URISyntaxException {

        try (
                FileReader fileReader = new FileReader(
                new File(this.getClass().getResource("resources/" + inFName).toURI()))) {

            JSONTokener tokener = new JSONTokener(fileReader);
            JSONObject jsonObject = new JSONObject(tokener);

            ArrayList<String> configList = new ArrayList<>();
            configList.add(jsonObject.optString("applicationID"));
            configList.add(jsonObject.optString("channelID"));
            configList.add(jsonObject.optString("guildID"));
            configList.add(jsonObject.optString("sessionID"));
            configList.add(jsonObject.optString("botAuthorization"));
            configList.add(jsonObject.optString("userAuthorization"));
            configList.add(jsonObject.optString("chatGPTKey"));

            return configList;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void writeStoryToJson(Story story, String inFName) {
        JSONObject jsonStory = new JSONObject();
        jsonStory.put("title", story.title);
        jsonStory.put("size", story.numPages);
        jsonStory.put("trailer", story.trailer);
        JSONArray jsonPages = new JSONArray();
        for (Page page : story.pages) {
            JSONObject jsonPage = new JSONObject();
            jsonPage.put("image", page.getImageUrl());
            jsonPage.put("text", page.getContent());
            jsonPage.put("pageNumber", jsonPages.length() + 1);
            jsonPages.put(jsonPage);
        }
        jsonStory.put("pages", jsonPages);
        try {
            String jsonString = jsonStory.toString(4);
            Files.write(Paths.get(inFName), jsonString.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
