package com.fullstackfox;

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
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void makeTitle() throws IOException {
        button_accept.setDisable(true);
        output_story.setText(StoryGeneration.getStory());
        String title = StoryGeneration.storyTitle(StoryGeneration.getStory());
        String url = Story.getTrailer();
        setOutput_image(url);
        output_name.setText(title);
        button_generate.setText("Regenerate Name");
        button_accept.setDisable(false);
    }

    @FXML
    void setOutput_image(String inUrl) throws IOException {
        Image imageU = new Image(inUrl);
        ImageView imageView = new ImageView(imageU);
        imageView.setFitHeight(360);
        imageView.setFitWidth(360);
        output_image.getChildren().add(imageView);
    }


    @FXML
    private void edit() throws IOException {
        String url = Story.getTrailer();
        setOutput_image(url);
        output_name.setEditable(true);
        button_accept.setDisable(false);
    }

    @FXML
    private void switchToPage() throws IOException {
        Story.setTitle(output_name.getText());
        App.setRoot("imagePromptEditor");
    }
}