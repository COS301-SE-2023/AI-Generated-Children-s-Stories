package com.fullstackfox;

import java.util.ArrayList;

public class PromptProcessor {

    String seed;

    public PromptProcessor() {
        seed = "123";
    }

    // ChatGPT ---

    // Creates the prompt for chatgpt to generate story
    public String storyPrompt(ArrayList<String> inputList) {
        String storyIdea = inputList.get(0);
        storyIdea = this.toJSONstring(storyIdea);
        String age = inputList.get(1);
        int storyLength = Integer.parseInt(inputList.get(2));
        storyLength /= 5;
        if (storyLength < 1) {
            storyLength = 1;
        }
        String lenDescription = "very long";
        if (storyLength <= 5) {
            lenDescription = "short";
        } else if (storyLength <= 10) {
            lenDescription = "medium length";
        } else if (storyLength <= 15) {
            lenDescription = "long";
        }
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("Write a children's story based using the following information:\\n");
        stringBuilder.append("1. Story Idea: " + storyIdea + "\\n");
        stringBuilder.append("2. The story must be written for a child of age " + age + ".\\n");
        stringBuilder
                .append("3. The story must be " + lenDescription + " and only " + storyLength + " paragraphs long.\\n");
        stringBuilder
                .append("It must be easy enough for the child to read and must only contain age appropriate content.");
        return stringBuilder.toString();
    }

    // Creates the prompt for chatgpt to generate story title
    public String storyTitlePrompt(String inStory) {
        inStory = this.toJSONstring(inStory);
        return "Create a very short tile for the following story, do not label it:\\n" + inStory;
    }

    // Creates the prompt for chatgpt to generate character description
    public String characterDescriptionPrompt(String inStory) {
        inStory = this.toJSONstring(inStory);
        return "Write a single sentence description of what the main character from the following story looks like.\\n"
                + inStory;
    }

    // Creates the prompt for chatgpt to generate story trailer description
    public String storyTrailerPrompt(String inStory) {
        inStory = this.toJSONstring(inStory);
        return "Extract the most important key moment from the following story and summarise it into a single line.\\n"
                + inStory;
    }

    // Creates the prompt for chatgpt to generate midjourney prompts
    public String genMidjourneyPromptsPrompt(String inStory, int inNumPages) {
        inStory = this.toJSONstring(inStory);
        return "Provide " + inNumPages
                + " prompts for Dall E for the following paragraphs in order to generate an image that captures the paragraphs content. Each prompt must be a vague, single line summery of the paragraph. Number each prompt.\\n"
                + inStory;
    }

    // Midjourney ---

    // Creates the prompt for midjourney to generate character image
    public String characterImagePrompt(String inPrompt) {
        inPrompt = this.toJSONstring(inPrompt);
        return inPrompt + " --seed " + seed;
    }

    // Creates the prompt for midjourney to generate all other images
    public String storyImagePrompt(String inUrl, String inPrompt) {
        inPrompt = this.toJSONstring(inPrompt);
        return inUrl + " " + inPrompt + " --seed " + seed;
    }

    // Helper Functions ---

    public String toJSONstring(String inString) {
        inString = inString.replace("\n", "\\n");
        inString = inString.replace("\"", "\\\"");
        return inString;
    }
}