package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class PrimaryController {

    @FXML
    private void switchToSecondary() throws IOException {
        App.setRoot("secondary");
    }

    @FXML
    private void switchToScreen() throws IOException {
        App.setRoot("screen");
    }

    @FXML
    private void switchToStory() throws IOException {
        App.setRoot("create-a-story");
    }
}
