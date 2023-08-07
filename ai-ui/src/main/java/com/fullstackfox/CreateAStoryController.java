package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class CreateAStoryController {

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void switchToCharacter() throws IOException {
        App.setRoot("character");
    }
}