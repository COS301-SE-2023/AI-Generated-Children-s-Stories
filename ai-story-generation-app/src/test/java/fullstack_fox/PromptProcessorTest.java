package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class PromptProcessorTest {

    @Test
    void storyPrompt() {
        //create an input list for the prompt to generate a story of genre Mystery
        //and for age 5
        ArrayList<String> inputList = new ArrayList<String>(){
            {
                add("Mystery");
                add("5");
            }
        };

        //set the expected output for the prompt
        String expectedOutput = "Write a children's story based using the following information:\\n1. Story Idea: Mystery\\n2. The maximum number of paragraphs is 4.\\n3. The story must be written for a child of age 5.\\nIt must be easy enough for the child to read and must only contain age appropriate content.";

        //create an instance of the class
        PromptProcessor promptProcessor = new PromptProcessor("123");

        String outputFromClass = promptProcessor.storyPrompt(inputList);
        Assertions.assertEquals(expectedOutput, outputFromClass);
    }


    @Test
    void characterDescriptionPrompt() {
        String inStory = "[{\"content\": \"I am a story.\"}]";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.characterDescriptionPrompt(inStory);

        //appends message at the beginning
        // \n changes to \\n
        String expectedOutput = "Write a single sentence description of the main characters appearance from the following story. \\n[{\\\"content\\\": \\\"I am a story.\\\"}]";

        Assertions.assertEquals(expectedOutput, output);

    }


    @Test
    void genMidjourneyPromptsPrompt() {
        String inStory = "[{\"content\": \"I am a story.\"}]";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.genMidjourneyPromptsPrompt(inStory, 3);

        String expectedOutput = "Provide 3 prompts for Dall E for the following paragraphs in order to generate an image that captures the paragraphs content. Each prompt must be a vague, single line summery of the paragraph. Number each prompt.\\n[{\\\"content\\\": \\\"I am a story.\\\"}]";

        Assertions.assertEquals(expectedOutput, output);

    }
}