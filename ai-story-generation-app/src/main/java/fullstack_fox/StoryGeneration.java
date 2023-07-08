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
        String storyPrompt = processPrompt.storyPrompt(inputList);
        String response = callApi.promptGPT(storyPrompt);
        String story = this.extractContent(response);

        System.out.println("--------");
        System.out.println("Story");
        System.out.println(story);
        System.out.println("--------\n");

        if (!story.isBlank()) {
            ArrayList<String> paragraphs = this.splitParagraphs(story);
            int numPages = paragraphs.size();

            String prompt = processPrompt.characterDescriptionPrompt(story);
            response = callApi.promptGPT(prompt);

            System.out.println("--------");
            System.out.println("Character Propmpt");
            System.out.println(this.extractContent(response));
            System.out.println("--------\n");

            String characterPrompt = processPrompt.characterImagePrompt(this.extractContent(response));

            String characterImageUrl = imageGenerator.generateImage(characterPrompt);
            System.out.println(characterImageUrl);

            prompt = processPrompt.genMidjourneyPromptsPrompt(story, numPages);
            response = callApi.promptGPT(prompt);

            System.out.println("--------");
            System.out.println("Midjourney Propmpts");
            String promptList = this.extractContent(response);
            System.out.println(promptList);
            System.out.println("--------\n");

            List<String> prompts = splitNumberedList(promptList);
            System.out.println("-----------------------------");

            for (int i = 0; i < prompts.size(); i++) {
                prompts.set(i, processPrompt.imagePrompt(characterImageUrl, prompts.get(i)));
            }

            System.out.println("Final Prompts");
            for (String item : prompts) {
                System.out.println(item);
            }

            // ArrayList<String> imageUrls = new ArrayList<String>();

            // for (int i = 0; i < prompts.size(); i++) {
            // String url = imageGenerator.generateImage(prompts.get(i));
            // imageUrls.add(url);
            // }
            // System.out.println("Story:");
            // ArrayList<Page> pages = new ArrayList<Page>();
            // for (int i = 0; i < paragraphs.size(); i++) {
            // Page newPage = new Page(paragraphs.get(i), imageUrls.get(i));
            // pages.add(newPage);
            // System.out.println("Page " + i);
            // pages.get(i).print();
            // }
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
