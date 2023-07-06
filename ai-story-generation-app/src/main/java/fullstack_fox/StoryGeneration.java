package fullstack_fox;

import java.net.URISyntaxException;
import java.util.ArrayList;

import org.json.*;

public class StoryGeneration {
    APICalls callApi;
    PromptProcessor processPrompt;
    ImageGeneration imageGenerator;

    public StoryGeneration(APICalls inApiLibrary) throws URISyntaxException {
        imageGenerator = new ImageGeneration(inApiLibrary);
        callApi = inApiLibrary;
        processPrompt = new PromptProcessor();
    }

    public void generateStory(ArrayList<String> inputList) throws URISyntaxException {
        String storyPrompt = processPrompt.storyPrompt(inputList);
        String response = callApi.promptGPT(storyPrompt);
        String story = this.extractContent(response);
        // System.out.println(story);
        if (!story.isBlank()) {
            ArrayList<String> paragraphs = this.splitParagraphs(story);

            ArrayList<String> prompts = new ArrayList<String>();
            
            String prompt = processPrompt.characterDescriptionPrompt(story);

            System.out.println("--------");
            System.out.println(prompt);
            System.out.println("--------");
            // response = callApi.promptGPT(prompt);
            // System.out.println("--------");
            // System.out.println("Character Propmpt");
            // System.out.println(this.extractContent(response));
            // System.out.println("--------");

            // prompt = processPrompt.genMidjourneyPromptsPrompy(story);
            // response = callApi.promptGPT(prompt);
            // System.out.println("--------");
            // System.out.println("Midjourney Propmpts");
            // System.out.println(this.extractContent(response));
            // System.out.println("--------");

            // for (int i = 0; i < paragraphs.size(); i++) {
            // String prompt = processPrompt.summarizePrompt(paragraphs.get(i));
            // response = callApi.promptGPT(prompt);
            // prompt = this.extractContent(response);
            // prompts.add(prompt);
            // }

            // ArrayList<String> imageUrls = new ArrayList<String>();

            // for (int i = 0; i < prompts.size(); i++) {
            //     String url = imageGenerator.generateImage(prompts.get(i));
            //     imageUrls.add(url);
            // }
            // System.out.println("Story:");
            // ArrayList<Page> pages = new ArrayList<Page>();
            // for (int i = 0; i < paragraphs.size(); i++) {
            //     Page newPage = new Page(paragraphs.get(i), imageUrls.get(i));
            //     pages.add(newPage);
            //     System.out.println("Page " + i);
            //     pages.get(i).print();
            // }
            // return the pages list
        }
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
}
