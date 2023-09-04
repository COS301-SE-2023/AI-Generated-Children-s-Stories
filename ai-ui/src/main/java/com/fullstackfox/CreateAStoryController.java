package com.fullstackfox;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;


import javafx.fxml.FXML;

import javafx.scene.control.*;


public class CreateAStoryController{
    @FXML
    private Button generationButton;
    @FXML
    private TextArea storyPrompt;
    @FXML
    private TextField age;
    @FXML
    private Slider lenSlider;
    @FXML
    private TextArea storyOut;

    @FXML
    private Button editButton;
    @FXML
    private Button discardButton;
    @FXML
    private Button acceptButton;
    @FXML
    private Button regenButton;

    Processors pro = Processors.getInstance();
    StoryGeneration gen = pro.getStoryGeneration();

    @FXML
    private void switchToHome() throws IOException {
            App.setRoot("home");
        
    }

    @FXML
    private void clearStory() throws IOException {
            App.setRoot("create-a-story");
    }

        @FXML
    private void switchToCharacter() throws IOException {
       
       gen.setStory(storyOut.getText());
      // System.out.println(storyOut.getText());
            App.setRoot("character");
    }

         @FXML
    private void edit() throws IOException {
        // storyPrompt.setEditable(false);
        // age.setEditable(false);
        // lenSlider.setDisable(true);
        storyOut.setEditable(true);
    }


    @FXML
    private void getPrompt() throws IOException, URISyntaxException {
         generationButton.setDisable(true);
        ArrayList<String> promptList = new ArrayList<>();
       // promptList.add("default prompt");
   
        if (storyPrompt.getText() != null && !storyPrompt.getText().isEmpty()) {
            String prompt = storyPrompt.getText();
            promptList.add(prompt);
          //  System.out.println(prompt);
        }
    
        if (age.getText() != null && !age.getText().isEmpty()) {
            try {
                Integer.parseInt(age.getText());
                String agePrompt = age.getText() ;
                String len = "" + Math.round(lenSlider.getValue());
                promptList.add(agePrompt);
                promptList.add(len);
               // System.out.println(agePrompt);
            } catch (NumberFormatException e) {
                System.out.println("Age was not a number!");
            }
        }
    
        setStory(promptList);
    }

        @FXML
    private void setStory(ArrayList <String> inStory) throws IOException{
           
     String story = "Story Failed to Generate";
     
     if(inStory != null){story =gen.storyInput(inStory);}
     storyOut.setText(story);
     //generationButton.setDisable(true);
     editButton.setDisable(false);
     acceptButton.setDisable(false);
     regenButton.setDisable(false);
     discardButton.setDisable(false);
    }



}