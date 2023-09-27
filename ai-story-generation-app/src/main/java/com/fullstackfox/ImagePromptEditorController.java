package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;

import java.io.IOException;


public class ImagePromptEditorController {
    private String prompts;
    @FXML
    private TextArea output_prompts;
    @FXML
    private Button button_accept;
    @FXML
    private Button button_edit;
    @FXML
    private Button button_generate;
    @FXML
    private Button button_discard;
    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }


    @FXML
    private void getPrompts() throws IOException {
        prompts = StoryGeneration.storyImagePrompts(StoryGeneration.getStory());
        output_prompts.setText(prompts);
        enableGeneration();
    }

    @FXML
    private void switchToPage() throws IOException {
        StoryGeneration.splitNumberedList(prompts);
        App.setRoot("story-page");
    }

    @FXML
    private void editPrompts() throws IOException {
        output_prompts.setEditable(true);
    }

    @FXML
    protected void disableGeneration() throws IOException {
        button_accept.setDisable(true);
        button_discard.setDisable(true);
        button_generate.setDisable(true);
    }

    @FXML
    protected void enableGeneration() throws IOException {
        button_accept.setDisable(false);
        button_discard.setDisable(false);
        button_generate.setDisable(false);
    }

}