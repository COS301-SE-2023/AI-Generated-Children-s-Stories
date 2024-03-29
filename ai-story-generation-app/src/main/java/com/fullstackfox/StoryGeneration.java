package com.fullstackfox;

import org.json.JSONArray;
import org.json.JSONObject;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;

public class StoryGeneration {
    private static StoryGeneration instance;
    private static APICalls callApi;
    private static PromptProcessor processPrompt;
    private static ImageGeneration imageGenerator;
    private static String story;
    private static String characterImageUrl;
    private static ArrayList<String> paragraphs;
    private static ArrayList<String> imagePrompts;

    static int currentPage;

    private StoryGeneration() throws URISyntaxException {
        callApi = new APICalls();
        imageGenerator = new ImageGeneration(callApi);
        processPrompt = new PromptProcessor();
        currentPage = 0;
    }


    public static StoryGeneration getInstance() throws URISyntaxException {
        if (instance == null) {
            instance = new StoryGeneration();
        }
        return instance;
    }

    // Generate story text
    public static String storyText(ArrayList<String> inputList) {
        String prompt = processPrompt.storyPrompt(inputList);
        String response = callApi.promptGPT(prompt);
        return extractContent(response);
    }

    public static String storyTitle(String story) {
        String currentPrompt = processPrompt.storyTitlePrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        return extractContent(response);
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public static ArrayList<String> characterImage(String story) throws URISyntaxException {
        String currentPrompt = processPrompt.characterDescriptionPrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        String characterPrompt = processPrompt.characterImagePrompt(extractContent(response));
        return imageGenerator.generateImage(characterPrompt);
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public static ArrayList<String> characterImageCustom(String prompt) throws URISyntaxException {
        String characterPrompt = processPrompt.characterImagePrompt(prompt);
        return imageGenerator.generateImage(characterPrompt);
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public static ArrayList<String> storyTrailerImage(String story) throws URISyntaxException {
        String currentPrompt = processPrompt.storyTrailerPrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        String trailerPrompt = processPrompt.storyImagePrompt(characterImageUrl, extractContent(response));
        return imageGenerator.generateImage(trailerPrompt);
    }

    public static ArrayList<String> storyTrailerImageCustom(String prompt) throws URISyntaxException {
        String trailerPrompt = processPrompt.storyImagePrompt(characterImageUrl, prompt);
        return imageGenerator.generateImage(trailerPrompt);
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public static ArrayList<String> pageImage(String inPrompt) throws URISyntaxException {
        String pagePrompt = processPrompt.storyImagePrompt(characterImageUrl, inPrompt);
        return imageGenerator.generateImage(pagePrompt);
    }

    // Call this to upscale a image
    public static String imageUpscale(ArrayList<String> inImageDetails, String inUpscale) throws URISyntaxException {
        return imageGenerator.upscaleImage(inImageDetails, inUpscale);
    }

    public static String storyImagePrompts(String inPrompt) {
        String imagePromptsPrompt = processPrompt.genMidjourneyPromptsPrompt(inPrompt, paragraphs.size());
        String response = callApi.promptGPT(imagePromptsPrompt);
        return extractContent(response);
    }

    public static void sendStory(){
        callApi.sendJsonObject();
    }

    public static String extractContent(String inResponseBody) {
        String finishReason = finish_reason(inResponseBody);
        if (finishReason.compareTo("stop") == 0) {
            JSONObject responseJson = new JSONObject(inResponseBody);
            JSONArray choicesArray = responseJson.getJSONArray("choices");
            JSONObject messageObject = choicesArray.getJSONObject(0).getJSONObject("message");
            return messageObject.getString("content");
        }
        return null;
    }

    public static String finish_reason(String inResponseBody) {
        JSONObject responseJson = new JSONObject(inResponseBody);
        if (responseJson.has("choices")) {
            JSONArray choicesArray = responseJson.getJSONArray("choices");
            if (!choicesArray.isEmpty()) {
                JSONObject firstChoice = choicesArray.getJSONObject(0);
                if (firstChoice.has("finish_reason")) {
                    String finishReason = firstChoice.getString("finish_reason");
                    System.out.println("Finish Reason: " + finishReason + ". Test Passed.");
                    return finishReason;
                }
            }
        }
        System.out.println("No finish reason found in the JSON response.");
        return "";
    }

    public static void setParagraphs() {
        String[] splittingArray = story.split("\n\n");
        paragraphs = new ArrayList<>(Arrays.asList(splittingArray));
        for (String paragraph : paragraphs) {
            System.out.println(paragraph);
        }
    }

    public static ArrayList<String> splitNumberedList(String inPromptList) {
        inPromptList = trim(inPromptList);
        ArrayList<String> resultList = new ArrayList<>();
        String[] lines = inPromptList.split("\n");
        for (String line : lines) {
            int dotIndex = line.indexOf(".");
            if (dotIndex != -1) {
                String item = line.substring(dotIndex + 1).trim();
                item = item.replaceAll("\"", "");
                resultList.add(item);
            }
        }
        return resultList;
    }

    public static String trim(String inPrompts) {
        int index = inPrompts.indexOf("1");

        if (index != -1) {
            return inPrompts.substring(index);
        } else {
            System.out.println("ChatGPT returned non numbered list");
        }
        return inPrompts;
    }

    public static String getStory() {
        return story;
    }

    public static void setStory(String inStory) {
        story = inStory;
    }

    public static void setCharacter(String character) {
        characterImageUrl = character;
    }

    public static void setImagePrompts(String inImagePrompts) {
        imagePrompts = splitNumberedList(inImagePrompts);
    }

    public static void incCurrentPage() {
        currentPage++;
    }

    public static String getCurrentParagraph(){
        return paragraphs.get(currentPage);
    }

    public static String getCurrentImagePrompt(){
        return imagePrompts.get(currentPage);
    }

    public static boolean lastPageCheck(){
        if(currentPage == paragraphs.size()){
            return true;
        }
        return false;
    }

    public static int getCurrentPage(){
        return currentPage;
    }
}