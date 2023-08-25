package com.fullstackfox;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.json.*;

public class StoryGeneration {
    APICalls callApi;
    PromptProcessor processPrompt;
    ImageGeneration imageGenerator;

    public StoryGeneration(APICalls inApiLibrary) throws URISyntaxException {
        imageGenerator = new ImageGeneration(inApiLibrary);
        callApi = inApiLibrary;
        processPrompt = new PromptProcessor("123");
    }
//public Story generateStory(ArrayList<String> inputList) throws URISyntaxException {
        // Generate story text
        public String storyMaker(ArrayList<String> inputList) {
        String currentPrompt = processPrompt.storyPrompt(inputList);
        String story = this.storyText(currentPrompt);
        return story;
        //System.out.println(story);
        }

        public String generateTitle (String story){
        //if (!story.isBlank()) {
            // Generate story title
             String currentPrompt = processPrompt.storyTitlePrompt(story);
            String storyTitle = this.storyTitle(currentPrompt);
            return storyTitle;
        }

            // Generate character image
            public String generateCharacter(String story) throws URISyntaxException{
            String currentPrompt = processPrompt.characterDescriptionPrompt(story);
            String characterImageUrl = this.characterImage(currentPrompt);
            return characterImageUrl;
            }

            // Generate trailer image
            
            public String trailerImage(String story, String characterImageUrl) throws URISyntaxException{
            String currentPrompt = processPrompt.storyTrailerPrompt(story);
            String storyTrailer = this.storyTrailer(currentPrompt, characterImageUrl);
                return storyTrailer;
            }

            // Generate story images
            public String oliverChange(String story, String characterImageUrl) throws URISyntaxException{
            ArrayList<String> paragraphs = this.splitParagraphs(story);
            int numPages = paragraphs.size();
            String currentPrompt = processPrompt.genMidjourneyPromptsPrompt(story, numPages);
            currentPrompt = this.storyImagePrompts(currentPrompt);
            System.out.println(currentPrompt);
            List<String> imagePrompts = splitNumberedList(currentPrompt);
            //ArrayList<String> storyImages = this.storyImages(imagePrompts, characterImageUrl);

                return "ahhhhhh";
            } 

            // Return final story
           // return this.compileStory(storyTitle, storyTrailer, paragraphs, storyImages);
       // }
       // return null;
    

    public String storyText(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String story = this.extractContent(response);
        return story;
    }

    public String storyTitle(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String storyTitle = this.extractContent(response);
        return storyTitle;
    }

    public String characterImage(String inPrompt) throws URISyntaxException {
        String response = callApi.promptGPT(inPrompt);
        String characterPrompt = processPrompt.characterImagePrompt(this.extractContent(response));
        String characterImageUrl = imageGenerator.generateImage(characterPrompt);
        return characterImageUrl;
    }

    public String storyTrailer(String inPrompt, String inCharacterImageUrl) throws URISyntaxException {
        String response = callApi.promptGPT(inPrompt);
        String trailerPrompt = processPrompt.storyImagePrompt(inCharacterImageUrl, this.extractContent(response));
        String trailerUrl = imageGenerator.generateImage(trailerPrompt);
        return trailerUrl;
    }

    public String storyImagePrompts(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String promptList = this.extractContent(response);
        return promptList;
    }

    public ArrayList<String> storyImages(List<String> inPrompts, String inCharacterImageUrl) throws URISyntaxException {
        for (int i = 0; i < inPrompts.size(); i++) {
            inPrompts.set(i, processPrompt.storyImagePrompt(inCharacterImageUrl,
                    inPrompts.get(i)));
        }
        ArrayList<String> imageUrls = new ArrayList<String>();
        for (int i = 0; i < inPrompts.size(); i++) {
            String url = imageGenerator.generateImage(inPrompts.get(i));
            imageUrls.add(url);
        }
        return imageUrls;
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
        // JSONObject responseJson = new JSONObject(inResponseBody);
        // JSONArray choicesArray = responseJson.getJSONArray("choices");
        // JSONObject firstChoice = choicesArray.getJSONObject(0);
        // String finishReason = firstChoice.getString("finish_reason");
        // System.out.println("Finish Reason: " + finishReason + ". Test Passed.");
        // return finishReason;


        JSONObject responseJson = new JSONObject(inResponseBody);

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