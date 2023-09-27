package com.fullstackfox;

import javafx.application.Platform;
import javafx.fxml.FXML;

import java.io.IOException;
import java.net.URISyntaxException;

public class HomeController {

    @FXML
    private void switchToSettings() throws IOException {
        App.setRoot("settings");
    }

    @FXML
    private void close() throws IOException {
        Platform.exit();
    }

    @FXML
    private void switchToStory() throws IOException, URISyntaxException {
        Story story = Story.getInstance();
        App.setRoot("create-a-story");
    }
}

