package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;

import java.io.IOException;


public class ImagePromptEditorController {
    private String prompts;
    @FXML
    private TextArea storyOut;

    @FXML
    private Button acceptButton;
    @FXML
    private Button editButton;


    @FXML
    private void switchToHome() throws IOException {

        App.setRoot("home");

    }

//
//    @FXML
//    private void getPrompts() throws IOException {
//        prompts = gen.storyImagePrompts(gen.getStory());
//        storyOut.setText(prompts);
//        acceptButton.setDisable(false);
//        editButton.setDisable(false);
//    }
//
//    @FXML
//    private void switchToPage() throws IOException {
//        gen.splitNumberedList(prompts);
//        App.setRoot("story-page");
//    }
//
//    @FXML
//    private void editPrompts() throws IOException {
//        storyOut.setEditable(true);
//    }


}