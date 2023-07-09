package fullstack_fox;

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

    public void generateStory(ArrayList<String> inputList) throws URISyntaxException {
        // Generate story text
        String currentPrompt = processPrompt.storyPrompt(inputList);
        String story = this.storyText(currentPrompt);

        if (!story.isBlank()) {
            // Generate story title
            // -------------------

            // Generate character image
            currentPrompt = processPrompt.characterDescriptionPrompt(story);
            String characterImageUrl = this.characterImage(currentPrompt);

            // Generate trailer image
            // -------------------

            // Generate story images
            ArrayList<String> paragraphs = this.splitParagraphs(story);
            int numPages = paragraphs.size();
            currentPrompt = processPrompt.genMidjourneyPromptsPrompt(story, numPages);
            currentPrompt = this.storyImagePrompts(currentPrompt);
            List<String> imagePrompts = splitNumberedList(currentPrompt);
            ArrayList<String> storyImages = this.storyImages(imagePrompts, characterImageUrl);

            // Return final story

            // return this.compileStory(paragraphs, storyImages);
        }
    }

    public String storyText(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        String story = this.extractContent(response);
        System.out.println("--------");
        System.out.println("Story");
        System.out.println(story);
        System.out.println("--------\n");

        return story;
    }

    public String characterImage(String inPrompt) throws URISyntaxException {
        String response = callApi.promptGPT(inPrompt);
        String characterPrompt = processPrompt.characterImagePrompt(this.extractContent(response));
        String characterImageUrl = imageGenerator.generateImage(characterPrompt);
        System.out.println(characterImageUrl);
        return characterImageUrl;
    }

    public String storyImagePrompts(String inPrompt) {
        String response = callApi.promptGPT(inPrompt);
        System.out.println("--------");
        System.out.println("Midjourney Propmpts");
        String promptList = this.extractContent(response);
        System.out.println(promptList);
        System.out.println("--------\n");
        return promptList;
    }

    public ArrayList<String> storyImages(List<String> inPrompts, String inCharacterImageUrl) throws URISyntaxException {
        for (int i = 0; i < inPrompts.size(); i++) {
            inPrompts.set(i, processPrompt.storyImagePrompt(inCharacterImageUrl,
                    inPrompts.get(i)));
        }

        System.out.println("Final Prompts");
        for (String item : inPrompts) {
            System.out.println(item);
        }

        System.out.println("--------\n");

        ArrayList<String> imageUrls = new ArrayList<String>();

        for (int i = 0; i < inPrompts.size(); i++) {
            String url = imageGenerator.generateImage(inPrompts.get(i));
            imageUrls.add(url);
        }

        return imageUrls;
    }

    public Story compileStory(ArrayList<String> inParagraphs, ArrayList<String> inStoryImages) {
        Story finalStory = new Story();
        System.out.println("Story:");
        
        for (int i = 0; i < inParagraphs.size(); i++) {
            Page newPage = new Page(inParagraphs.get(i), inParagraphs.get(i));
            finalStory.addPage(newPage);
            System.out.println("Page " + i);
            finalStory.printPage(i);
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
        JSONArray choicesArray = responseJson.getJSONArray("choices");
        JSONObject firstChoice = choicesArray.getJSONObject(0);
        String finishReason = firstChoice.getString("finish_reason");
        System.out.println("Finish Reason: " + finishReason + ". Test Passed.");
        return finishReason;
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
