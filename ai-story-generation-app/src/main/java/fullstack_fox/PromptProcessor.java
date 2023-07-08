package fullstack_fox;

import java.util.ArrayList;

public class PromptProcessor {

    String seed;

    public PromptProcessor(String inSeed) {
        seed = inSeed;
    }

    public String toJSONstring(String inString) {
        inString = inString.replace("\n", "\\n");
        inString = inString.replace("\"", "\\\"");
        return inString;
    }

    public String storyPrompt(ArrayList<String> inputList) {
        String storyIdea = inputList.get(0);
        storyIdea = this.toJSONstring(storyIdea);
        String age = inputList.get(1);

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("Write a children's story based using the following information:\\n");
        stringBuilder.append("1. Story Idea: ").append(storyIdea).append("\\n");
        stringBuilder.append("2. The story must be written for a child of age ").append(age).append(".\\n");
        stringBuilder
                .append("It must be easy enough for the child to read and must only contain age appropriate content.");
        return stringBuilder.toString();
    }

    public String characterDescriptionPrompt(String inStory) {
        inStory = this.toJSONstring(inStory);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(
                "Write a single sentence description of what the main character from the following story looks like. \\n");
        stringBuilder.append(inStory);
        return stringBuilder.toString();
    }

    public String characterImagePrompt(String inPrompt) {
        inPrompt = this.toJSONstring(inPrompt);
        return inPrompt + " --seed " + seed;
    }

    public String genMidjourneyPromptsPrompt(String inStory, int inNumPages) {
        inStory = this.toJSONstring(inStory);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(
                "Provide " + inNumPages
                        + " prompts for Dall E for the following paragraphs in order to generate an image that captures the paragraphs content. Each prompt must be a vague, single line summery of the paragraph. Number each prompt.\\n");
        stringBuilder.append(inStory.replace("\n", "\\n"));
        return stringBuilder.toString();
    }

    public String imagePrompt(String inUrl, String inPrompt) {
        inPrompt = this.toJSONstring(inPrompt);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(inUrl + " ");
        stringBuilder.append(inPrompt);
        stringBuilder.append(" --seed " + seed);
        return stringBuilder.toString();
    }
}