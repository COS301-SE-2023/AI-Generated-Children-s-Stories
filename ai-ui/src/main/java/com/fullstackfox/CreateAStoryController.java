package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Slider;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;


public class CreateAStoryController {

    StoryGeneration storyGeneration;

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

    public CreateAStoryController() throws URISyntaxException {
        storyGeneration = StoryGeneration.getInstance();
    }

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
        StoryGeneration.setStory(storyOut.getText());
        App.setRoot("character");
    }

    @FXML
    private void edit() throws IOException {
        storyOut.setEditable(true);
    }


    @FXML
    private void getPrompt() throws IOException, URISyntaxException {
        generationButton.setDisable(true);
        ArrayList<String> promptList = new ArrayList<>();
        promptList.add(storyPrompt.getText());
        promptList.add(age.getText());
        promptList.add("" + Math.round(lenSlider.getValue()));
        this.setStory(promptList);
    }

    @FXML
    private void setStory(ArrayList<String> inPromptList) throws URISyntaxException {
        String story = "Story Failed to Generate";
        if (inPromptList != null) {
            String prompt = StoryGeneration.storyInput(inPromptList);
            story = StoryGeneration.storyText(prompt);
        }
        storyOut.setText(story);
        editButton.setDisable(false);
        acceptButton.setDisable(false);
        regenButton.setDisable(false);
        discardButton.setDisable(false);
    }
}