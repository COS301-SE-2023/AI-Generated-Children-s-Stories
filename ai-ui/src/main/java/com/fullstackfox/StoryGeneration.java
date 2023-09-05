package com.fullstackfox;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.json.*;

public class StoryGeneration {
    APICalls callApi;
    PromptProcessor processPrompt;
    ImageGeneration imageGenerator;
    private String seed;
    private String story;
    private String charURL;

    public StoryGeneration(APICalls inApiLibrary, String inSeed) throws URISyntaxException {
        callApi = inApiLibrary;
        imageGenerator = new ImageGeneration(inApiLibrary);
        processPrompt = new PromptProcessor(inSeed);
        seed = inSeed;
    }

    public void setStory(String finalStory) {
        story = finalStory;
        return;
    }
    public String getStory() {
        return story;
    }

     public void setChar(String character) {
        charURL = character;
        return;
    }
    public String getChar() {
        return charURL;
    }

    // Generate story text
    public String storyInput(ArrayList<String> inputList) {
        String currentPrompt = processPrompt.storyPrompt(inputList);
        story = this.storyText(currentPrompt);
        return story;
    }

    public String storyText(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String story = this.extractContent(response);
        return story;
    }

    public String storyTitle(String story) {
        String currentPrompt = processPrompt.storyTitlePrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        String storyTitle = this.extractContent(response);
        return storyTitle;
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public ArrayList<String> characterImage(String story) throws URISyntaxException {
        String currentPrompt = processPrompt.characterDescriptionPrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        String characterPrompt = processPrompt.characterImagePrompt(this.extractContent(response));
        ArrayList<String> characterImageDetails = imageGenerator.generateImages(characterPrompt);
        return characterImageDetails;
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public ArrayList<String> characterImageCustom(String prompt) throws URISyntaxException {
        String characterPrompt = processPrompt.characterImagePrompt(prompt);
        ArrayList<String> characterImageDetails = imageGenerator.generateImages(characterPrompt);
        return characterImageDetails;
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public ArrayList<String> storyTrailerImage(String story, String inCharacterImageUrl) throws URISyntaxException {
        String currentPrompt = processPrompt.storyTrailerPrompt(story);
        String response = callApi.promptGPT(currentPrompt);
        String trailerPrompt = processPrompt.storyImagePrompt(inCharacterImageUrl, this.extractContent(response));
        ArrayList<String> trailerUrl = imageGenerator.generateImages(trailerPrompt);
        return trailerUrl;
    }

    public ArrayList<String> storyTrailerImageCustom(String inCharacterImageUrl,String prompt) throws URISyntaxException {
        String trailerPrompt = processPrompt.storyImagePrompt(inCharacterImageUrl, prompt);
        ArrayList<String> trailerUrl = imageGenerator.generateImages(trailerPrompt);
        return trailerUrl;
    }

    // Index 0 = url | Index 1 = messageID (Only used for upscaling)
    public ArrayList<String> pageImage(String inPrompt, String inCharacterImageUrl) throws URISyntaxException {
        String pagePrompt = processPrompt.storyImagePrompt(inCharacterImageUrl, inPrompt);
        ArrayList<String> pageImageDetails = imageGenerator.generateImages(pagePrompt);
        return pageImageDetails;
    }

    // Call this to upscale a image
    public String imageUpscale(ArrayList<String> inImageDetails, String inUpscale) throws URISyntaxException {
        String upscaledImage = imageGenerator.upscaleImage(inImageDetails, inUpscale);
        return upscaledImage;
    }

    public String storyImagePrompts(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String promptList = this.extractContent(response);
        return promptList;
    }

    public Story compileStory(String inStoryTitle, String inStoryTrailer, ArrayList<String> inParagraphs,
            ArrayList<String> inStoryImages) {
        Story finalStory = new Story(inStoryTitle, inStoryTrailer);
        for (int i = 0; i < inParagraphs.size(); i++) {
            Page newPage = new Page(inParagraphs.get(i), inStoryImages.get(i));
            finalStory.addPage(newPage);
        }
        return finalStory;
    }

    public String extractContent(String inResponseBody) {
        String finishReason = this.finish_reason(inResponseBody);
        if (finishReason.compareTo("stop") == 0) {
            JSONObject responseJson = new JSONObject(inResponseBody);
            JSONArray choicesArray = responseJson.getJSONArray("choices");
            JSONObject messageObject = choicesArray.getJSONObject(0).getJSONObject("message");
            String content = messageObject.getString("content");
            return content;
        }
        return null;
    }

    public String finish_reason(String inResponseBody) {
        JSONObject responseJson = new JSONObject(inResponseBody);
        // JSONArray choicesArray = responseJson.getJSONArray("choices");
        // JSONObject firstChoice = choicesArray.getJSONObject(0);
        // String finishReason = firstChoice.getString("finish_reason");
        // System.out.println("Finish Reason: " + finishReason + ". Test Passed.");
        // return finishReason;

        if (responseJson.has("choices")) {
            JSONArray choicesArray = responseJson.getJSONArray("choices");

            if (choicesArray.length() > 0) {
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

    /// Splits the story into paragraphs
    /// @param inStory The story to split
    /// @return An ArrayList of paragraphs
    public ArrayList<String> splitParagraphs(String inStory) {
        String[] paragraphs = inStory.split("\n");
        ArrayList<String> list = new ArrayList<>();

        for (String paragraph : paragraphs) {
            String trimmedParagraph = paragraph.trim();
            if (!trimmedParagraph.isEmpty()) {
                list.add(trimmedParagraph);
            }
        }
        return list;
    }

    public List<String> splitNumberedList(String inPromptList) {
        inPromptList = this.trim(inPromptList);
        List<String> resultList = new ArrayList<>();
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

    public String trim(String inPrompts) {
        int index = inPrompts.indexOf("1");

        if (index != -1) {
            return inPrompts.substring(index);
        } else {
            System.out.println("ChatGPT returned non numbered list");
        }
        return inPrompts;
    }
}