package com.fullstackfox;

import java.io.IOException;

import javafx.application.Platform;
import javafx.fxml.FXML;

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
    private void switchToStory() throws IOException {
        App.setRoot("create-a-story");
    }
}

