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

    @FXML
    private Button button_generate;
    @FXML
    private Button button_edit;
    @FXML
    private Button button_discard;
    @FXML
    private Button button_accept;
    @FXML
    private TextArea input_story_idea;
    @FXML
    private TextField input_age;
    @FXML
    private Slider input_length;
    @FXML
    private TextArea output_story;

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void clearStory() throws IOException {
        App.setRoot("create-a-story");
    }

    @FXML
    private void switchToCharacter() throws IOException, URISyntaxException {
        StoryGeneration.getInstance().setStory(output_story.getText());
        App.setRoot("character");
    }

    @FXML
    private void edit() throws IOException {
        if(output_story.isEditable())
        {
            output_story.setEditable(false);
        }
        else {
            output_story.setEditable(true);
        }
    }


    @FXML
    private void getPrompt() throws IOException, URISyntaxException {
        ArrayList<String> promptList = new ArrayList<>();
        promptList.add(input_story_idea.getText());
        promptList.add(input_age.getText());
        promptList.add("" + Math.round(input_length.getValue()));
        setStory(promptList);
    }

    @FXML
    private void setStory(ArrayList<String> inPromptList) throws URISyntaxException {
        String story = StoryGeneration.getInstance().storyText(inPromptList);
        System.out.println(
                "create a story controller: "
        );
        System.out.println(story);
        output_story.setText(story);
        enableGeneration();
    }

    @FXML
    private void disableGeneration(){
        button_edit.setDisable(true);
        button_accept.setDisable(true);
        button_discard.setDisable(true);
        button_generate.setDisable(true);
    }

    private void enableGeneration(){
        button_edit.setDisable(false);
        button_accept.setDisable(false);
        button_discard.setDisable(false);
        button_generate.setDisable(false);
    }

}