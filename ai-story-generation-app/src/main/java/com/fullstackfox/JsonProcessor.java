package com.fullstackfox;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;


public class JsonProcessor {
    private String apiKey;

    public JsonProcessor() {
    }

    public ArrayList<String> readJson() {
        try (InputStream inputStream = this.getClass().getResourceAsStream("config.json")) {
            if (inputStream != null) {
                // Read the resource using BufferedReader or any other appropriate method
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                    JSONTokener tokener = new JSONTokener(reader);
                    JSONObject jsonObject = new JSONObject(tokener);
                    ArrayList<String> configList = new ArrayList<>();
                    configList.add(jsonObject.optString("applicationID"));
                    configList.add(jsonObject.optString("channelID"));
                    configList.add(jsonObject.optString("guildID"));
                    configList.add(jsonObject.optString("sessionID"));
                    configList.add(jsonObject.optString("botAuthorization"));
                    configList.add(jsonObject.optString("userAuthorization"));
                    configList.add(jsonObject.optString("chatGPTKey"));
                    configList.add(jsonObject.optString("apiKey"));
                    return configList;
                }
            } else {
                // The resource could not be found
                System.out.println("Resource not found: config.json");
            }
        } catch (IOException e) {
            // Handle any potential IO exceptions
            e.printStackTrace();
        }
        return null;
    }

    public JSONObject writeStoryToJson() {
        JSONObject jsonStory = new JSONObject();
        jsonStory.put("apiKey", apiKey);

        JSONObject jsonStoryObject = new JSONObject();
        jsonStoryObject.put("title", Story.getTitle());
        jsonStoryObject.put("trailer", Story.getTrailer());

        JSONArray jsonPages = new JSONArray();
        for (Page page : Story.getPages()) {
            JSONObject jsonPage = new JSONObject();
            jsonPage.put("image", page.getImageUrl());
            jsonPage.put("text", page.getContent());
            jsonPages.put(jsonPage);
        }

        jsonStoryObject.put("pages", jsonPages);
        jsonStoryObject.put("userStories", new JSONArray());
        jsonStory.put("story", jsonStoryObject);
        return jsonStory;
    }

    public void setApiKey(String inApiKey) {
        apiKey = inApiKey;
    }

}
