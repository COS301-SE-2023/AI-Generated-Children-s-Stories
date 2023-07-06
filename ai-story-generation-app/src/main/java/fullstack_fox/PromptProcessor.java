package fullstack_fox;

import java.util.ArrayList;

public class PromptProcessor {

    public PromptProcessor() {
    }

    public String toJSONstring (String inString){
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
        stringBuilder.append("2. The maximum number of paragraphs is 4.\\n");
        stringBuilder.append("3. The story must be written for a child of age ").append(age).append(".\\n");
        stringBuilder
                .append("It must be easy enough for the child to read and must only contain age appropriate content.");
        return stringBuilder.toString();
    }

    public String characterDescriptionPrompt(String inStory) {
        inStory = this.toJSONstring(inStory);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(
                "Write a single sentence description of the main characters appearance from the following story. \\n");
        stringBuilder.append(inStory);
        return stringBuilder.toString();
    }

    public String genMidjourneyPromptsPrompy(String inStory) {
        inStory = this.toJSONstring(inStory);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(
                "Provide 7 prompts for Dall E for the following paragraphs in order to generate an image that captures the paragraphs content. Each prompt must be a vague, single line summery of the paragraph. \\n");
        stringBuilder.append(inStory.replace("\n", "\\n"));
        return stringBuilder.toString();
    }

    // public String summarizePrompt(String inParagraph) {
    // StringBuilder stringBuilder = new StringBuilder();
    // stringBuilder.append(
    // "Summarise the paragraph below. The extracted concept must be short as it
    // will be used as an image generation prompt.\\n");
    // stringBuilder.append(inParagraph);

    // return stringBuilder.toString();
    // }
}