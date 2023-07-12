package fullstack_fox;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class PromptProcessorTest {

    //test all cases!
    @Test
    void storyPrompt() {
        //-----------   prompt 1 ------------//
        ArrayList<String> inputList = new ArrayList<String>(){
            {
                add("Mystery"); //genre = mystery
                add("3"); //age = 3
                add("5"); //len = short
            }
        };

        //create an instance of the class
        PromptProcessor promptProcessor = new PromptProcessor("123");

        String outputFromClass = promptProcessor.storyPrompt(inputList);
        String expectedOutput = "Write a children's story based using the following information:\\n1. Story Idea: Mystery\\n2. The story must be written for a child of age 3.\\n3. The story must be short and only 1 paragraphs long.\\nIt must be easy enough for the child to read and must only contain age appropriate content.";
        Assertions.assertEquals(expectedOutput, outputFromClass);


        //-----------   prompt 2 ------------//
        inputList = new ArrayList<String>(){
            {
                add("Drama"); //genre = mystery
                add("12"); //age = 3
                add("17"); //len = short
            }
        };

        outputFromClass = promptProcessor.storyPrompt(inputList);
        expectedOutput = "Write a children's story based using the following information:\\n1. Story Idea: Drama\\n2. The story must be written for a child of age 12.\\n3. The story must be short and only 3 paragraphs long.\\nIt must be easy enough for the child to read and must only contain age appropriate content.";
        Assertions.assertEquals(expectedOutput, outputFromClass);

    }

    @Test
    void storyTitlePrompt() {
        String inStory = "[{\"content\": \"I am a story.\"}]";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.storyTitlePrompt(inStory);

        String expectedOutput = "Create a very short tile for the following story, do not label it:\\n" +
                "[{\\\"content\\\": \\\"I am a story.\\\"}]";

        Assertions.assertEquals(expectedOutput, output);
    }

    @Test
    void characterDescriptionPrompt() {
        String inStory = "[{\"content\": \"I am a story.\"}]";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.characterDescriptionPrompt(inStory);

        //appends message at the beginning
        // \n changes to \\n
        String expectedOutput = "Write a single sentence description of what the main character from the following story looks like.\\n[{\\\"content\\\": \\\"I am a story.\\\"}]";

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


    @Test
    void storyTrailerPrompt() {
        String inStory = "[{\"content\": \"I am a story.\"}]";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.storyTrailerPrompt(inStory);

        String expectedOutput = "Extract the most important key moment from the following story and summarise it into a single line.\\n[{\\\"content\\\": \\\"I am a story.\\\"}]";

        System.out.println(expectedOutput);
        Assertions.assertEquals(expectedOutput, output);
    }

    @Test
    void characterImagePrompt() {
        String inStory = "image";

        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.characterImagePrompt(inStory);

        String expectedOutput = "image --seed 123";

        System.out.println(expectedOutput);
        Assertions.assertEquals(expectedOutput, output);
    }

    @Test
    void storyImagePrompt() {
        PromptProcessor promptProcessor = new PromptProcessor("123");
        String output = promptProcessor.storyImagePrompt("url", "prompt");

        String expectedOutput = "url prompt --seed 123";

        System.out.println(expectedOutput);
        Assertions.assertEquals(expectedOutput, output);
    }
}