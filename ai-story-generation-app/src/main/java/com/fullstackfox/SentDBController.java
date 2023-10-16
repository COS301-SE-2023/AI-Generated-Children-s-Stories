package com.fullstackfox;

import javafx.fxml.FXML;

import java.io.IOException;

public class SentDBController {
    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }
}