package com.fullstackfox;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

import java.io.IOException;


public class TrailerNameController {
    @FXML
    private TextArea output_story;
    @FXML
    private Pane output_image;
    @FXML
    private TextField output_name;
    @FXML
    private Button button_generate;
    @FXML
    private Button button_accept;
    @FXML
    private Button button_discard;
    @FXML
    private Button button_edit;

    public TrailerNameController() {
        Platform.runLater(() -> {
            output_story.setText(StoryGeneration.getStory());
            String url = Story.getTrailer();
            setOutput_image(url);
        });
    }

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void makeTitle() {
        String title = StoryGeneration.storyTitle(StoryGeneration.getStory());
        output_name.setText(title);
        button_generate.setText("Regenerate Name");
    }

    @FXML
    private void edit() throws IOException {
        String url = Story.getTrailer();
        setOutput_image(url);
        output_name.setEditable(true);
    }

    @FXML
    void setOutput_image(String inUrl){
        Image imageU = new Image(inUrl);
        ImageView imageView = new ImageView(imageU);
        imageView.setFitHeight(380);
        imageView.setFitWidth(380);
        output_image.getChildren().add(imageView);
    }

    @FXML
    private void switchToPage() throws IOException {
        Story.setTitle(output_name.getText());
        App.setRoot("image-prompt-editor");
    }

    @FXML
    protected void disableGeneration() throws IOException {
        button_accept.setDisable(true);
        button_discard.setDisable(true);
        button_generate.setDisable(true);
        button_edit.setDisable(true);
    }

    @FXML
    protected void enableGeneration() throws IOException {
        button_accept.setDisable(false);
        button_discard.setDisable(false);
        button_generate.setDisable(false);
        button_edit.setDisable(false);
    }
}