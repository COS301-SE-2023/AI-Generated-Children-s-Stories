package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.Pane;

import java.io.IOException;


public class TrailerNameController {
    @FXML
    private TextArea story;
    @FXML
    private Pane image;
    @FXML
    private TextField name;
    @FXML
    private Button regenButton;
    @FXML
    private Button acceptButton;

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

//    @FXML
//    private void makeTitle() throws IOException, URISyntaxException {
//        story.setText(gen.getStory());
//        String title = gen.storyTitle(gen.getStory());
//        String url = gen.getTrailer();
//        Image imageU = new Image(url);
//        ImageView imageView = new ImageView(imageU);
//        imageView.setFitHeight(360);
//        imageView.setFitWidth(360);
//        image.getChildren().add(imageView);
//        name.setText(title);
//        regenButton.setText("Regenerate Name");
//        acceptButton.setDisable(false);
//    }
//
//    @FXML
//    private void edit() throws IOException, URISyntaxException {
//        story.setText(gen.getStory());
//        //String title=gen.storyTitle(gen.getStory());
//        String url = gen.getTrailer();
//        Image imageU = new Image(url);
//        ImageView imageView = new ImageView(imageU);
//        imageView.setFitHeight(360);
//        imageView.setFitWidth(360);
//        image.getChildren().add(imageView);
//        // name.setText(title);
//        name.setEditable(true);
//        //   regenButton.setText("Regenerate Name");
//        acceptButton.setDisable(false);
//    }
//
//    @FXML
//    private void switchToPage() throws IOException {
//        gen.setTitle(name.getText());
//        //  App.setRoot("story-page");
//        App.setRoot("imagePromptEditor");
//    }
}