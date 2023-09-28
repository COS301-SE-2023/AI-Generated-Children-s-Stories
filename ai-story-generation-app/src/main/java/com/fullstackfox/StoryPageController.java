package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;

import java.io.IOException;
import java.net.URISyntaxException;

public class StoryPageController extends UiParent {

    @FXML
    private Label title;

    @FXML
    private TextArea output_paragraph;
    public StoryPageController() {
        super(true);
    }

    @FXML
    private void generate() throws IOException, URISyntaxException {
        list = StoryGeneration.pageImage(StoryGeneration.getCurrentImagePrompt());
        finalImage = list.get(0);
        setImage(finalImage);
    }

    @FXML
    private void generateCustom() throws IOException, URISyntaxException {
        list = StoryGeneration.pageImage(input_custom_prompt.getPromptText());
        finalImage = list.get(0);
        setImage(finalImage);
    }

    @FXML
    private void next() throws IOException {
        Page newPage = new Page(StoryGeneration.getCurrentParagraph(), finalImage);
        Story.addPage(newPage);
        StoryGeneration.incCurrentPage();
        if (StoryGeneration.lastPageCheck()) {
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Completed");
            alert.setHeaderText(null);
            alert.setContentText("Story sent to database");
            alert.showAndWait();
            Story.printStory();
            StoryGeneration.sendStory();
        } else {
            title.setText("Page " + (StoryGeneration.getCurrentPage()+1));
            output_image.getChildren().clear();
            output_paragraph.setText(StoryGeneration.getCurrentParagraph());
            baseState();
        }
    }


    private void baseState() throws IOException {
        button_accept.setDisable(true);
        disableUpscale();
    }
}