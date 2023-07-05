package fullstack_fox;

import java.net.URISyntaxException;
import java.util.ArrayList;

public class App {
    public static void main(String[] args) throws URISyntaxException {
        // Set up
        APICalls apiLibrary = new APICalls();
        StoryGeneration storyGenerator = new StoryGeneration(apiLibrary);

        // GUI Input
        GUI gui = new GUI();
        gui.displayStoryInputForm();
        ArrayList<String> inputs = gui.getInputs();

        boolean check = true;

        if (inputs.size() == 2) {
            for (String input : inputs) {
                if (input.isBlank()) {
                    check = false;
                }
            }
        } else {
            check = false;
        }

        if (check) {
            storyGenerator.generateStory(inputs);
        }
    }
}