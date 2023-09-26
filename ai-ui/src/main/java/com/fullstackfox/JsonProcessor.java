package com.fullstackfox;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;


public class JsonProcessor {

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
                    configList.add(jsonObject.optString("midjourneySeed"));
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

    public void writeStoryToJson(Story story, String inFName) {
        JSONObject jsonStory = new JSONObject();
        jsonStory.put("title", Story.getTitle());
        jsonStory.put("trailer", Story.getTrailer());
        JSONArray jsonPages = new JSONArray();
        for (Page page : Story.getPages()) {
            JSONObject jsonPage = new JSONObject();
            jsonPage.put("image", page.getImageUrl());
            jsonPage.put("text", page.getContent());
            // jsonPage.put("pageNumber", jsonPages.length() + 1);
            jsonPages.put(jsonPage);
        }
        jsonStory.put("pages", jsonPages);
        // New Code ---
        jsonStory.put("userStories", new JSONArray());
        try {
            String jsonString = jsonStory.toString(4);
            Files.write(Paths.get(inFName), jsonString.getBytes());

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
