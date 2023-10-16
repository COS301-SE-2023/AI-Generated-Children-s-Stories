package com.fullstackfox;

import javafx.fxml.FXML;

import java.io.IOException;
import java.net.URISyntaxException;

public class TrailerImageController extends UiParent {

    @FXML
    private void customTrailer() throws IOException, URISyntaxException {
        String prompt = this.input_custom_prompt.getText();
        list = StoryGeneration.storyTrailerImageCustom(prompt);
        String url = list.get(0);
        setImage(url);
    }

    @FXML
    private void makeTrailer() throws IOException, URISyntaxException {
        list = StoryGeneration.storyTrailerImage(StoryGeneration.getStory());
        String url = list.get(0);
        setImage(url);
    }


    @FXML
    private void switchToName() throws IOException {
        App.setRoot("trailer-name");
        Story.setTrailer(finalImage);
    }
}