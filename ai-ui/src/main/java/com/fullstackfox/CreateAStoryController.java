package com.fullstackfox;

import java.io.IOException;
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

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }
        @FXML
    private void switchToCharacter() throws IOException {
        App.setRoot("character");
    }

        @FXML
    private void getPrompt() throws IOException{
     String prompt = "default prompt";
     
     if(storyPrompt.getText() != null && !storyPrompt.getText().isEmpty()){
        prompt = "Prompt: " + storyPrompt.getText();
        System.out.println(prompt);
     }
     if(age.getText() != null && !age.getText().isEmpty()){
        try {
            Integer.parseInt(age.getText());
            
            prompt = prompt+ "\n Age: " + age.getText() + "\n Length:" + Math.round(lenSlider.getValue());
     System.out.println(prompt); 
        } catch (NumberFormatException e) {
            System.out.println("Age was not a number!");
        }
     }

     setStory(prompt);
    }

        @FXML
    private void setStory(String inStory) throws IOException{
     String story = "prompt was blank :(";
     if(inStory != null){story = inStory;}
     storyOut.setText(story);
    }



}