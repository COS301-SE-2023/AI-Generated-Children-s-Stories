package com.fullstackfox;

import javafx.fxml.FXML;

import java.io.IOException;

public class PagePreviewController {

    @FXML
    private void switchToHome() throws IOException {

        App.setRoot("home");

    }

    @FXML
    private void switchToName() throws IOException {

        App.setRoot("trailer-name");

    }
}