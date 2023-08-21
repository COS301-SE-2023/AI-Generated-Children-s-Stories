package com.fullstackfox;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javafx.fxml.FXML;

import javafx.scene.control.*;


public class CreateAStoryController {
    
    //private Button generationButton;
    @FXML
    private TextArea storyPrompt;
    @FXML
    private TextField age;
    @FXML
    private Slider lenSlider;
    @FXML
    private TextArea storyOut;

    private APICalls api = new APICalls();
    private StoryGeneration storyMade;
    
    
    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }
        @FXML
    private void switchToCharacter() throws IOException {
        App.setRoot("character");
    }

    @FXML
    private void getPrompt() throws IOException, URISyntaxException {
        storyMade = new StoryGeneration(api);
        ArrayList<String> promptList = new ArrayList<>();
        promptList.add("default prompt");
    
        if (storyPrompt.getText() != null && !storyPrompt.getText().isEmpty()) {
            String prompt = "Prompt: " + storyPrompt.getText();
            promptList.add(prompt);
            System.out.println(prompt);
        }
    
        if (age.getText() != null && !age.getText().isEmpty()) {
            try {
                Integer.parseInt(age.getText());
                String agePrompt = "Age: " + age.getText() + "\n Length: " + Math.round(lenSlider.getValue());
                promptList.add(agePrompt);
                System.out.println(agePrompt);
            } catch (NumberFormatException e) {
                System.out.println("Age was not a number!");
            }
        }
    
        setStory(promptList);
    }

        @FXML
    private void setStory(ArrayList <String> inStory) throws IOException{
     String story = "";
     if(inStory != null){story = storyMade.storyMaker(inStory);}
     storyOut.setText(story);
    }



}