package com.fullstackfox;

import javafx.fxml.FXML;

import java.io.IOException;
import java.net.URISyntaxException;

public class CharacterController extends UiParent {

    @FXML
    private void customCharacter() throws IOException, URISyntaxException {
        String prompt = this.input_custom_prompt.getText();
        list = StoryGeneration.characterImageCustom(prompt);
        String url = list.get(0);
        setImage(url);
    }

    @FXML
    private void makeCharacter() throws URISyntaxException, IOException {
        list = StoryGeneration.characterImage(StoryGeneration.getStory());
        String url = list.get(0);
        setImage(url);
    }

    @FXML
    private void switchToTrailer() throws IOException {
        App.setRoot("trailer-image");
    }

}