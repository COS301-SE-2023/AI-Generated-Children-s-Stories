package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.TextArea;

import java.io.IOException;
import java.net.URISyntaxException;

public class TrailerImageController extends UiParent {
    @FXML
    private TextArea output_story;

    @FXML
    private void customTrailer() throws IOException, URISyntaxException {
        String prompt = this.input_custom_prompt.getText();
        list = StoryGeneration.storyTrailerImageCustom(prompt);
        String url = list.get(0);
        setImage(url);
        Story.setTrailer(url);
    }

    @FXML
    private void makeTrailer() throws IOException, URISyntaxException {
        list = StoryGeneration.storyTrailerImage(StoryGeneration.getStory());
        String url = list.get(0);
        setImage(url);
        Story.setTrailer(url);
    }


    @FXML
    private void switchToName() throws IOException {
        App.setRoot("trailer-name");
    }
}