package fullstack_fox;

import java.util.ArrayList;

public class PromptProcessor {

    public PromptProcessor() {
    }

    public String storyPrompt(ArrayList<String> inputList) {
        String storyIdea = inputList.get(0);
        String age = inputList.get(1);

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("Write a children's story based using the following information:\\n");
        stringBuilder.append("1. Story Idea: ").append(storyIdea).append("\\n");
        stringBuilder.append("2. The maximum number of paragraphs is 4.\\n");
        stringBuilder.append("3. The story must be written for a child of age ").append(age).append(".\\n");
        stringBuilder
                .append("It must be easy enough for the child to read and must only contain age appropriate content.");

                System.out.println(stringBuilder.toString() + "\n\n");
        return stringBuilder.toString();
    }
    
    public String summarizePrompt(String inParagraph) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("Summarise the paragraph below. The extracted concept must be short as it will be used as an image generation prompt.\\n");
        stringBuilder.append(inParagraph);

        return stringBuilder.toString();
    }
}
