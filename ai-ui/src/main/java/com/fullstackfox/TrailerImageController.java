package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class TrailerImageController {

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void switchToName() throws IOException {
        App.setRoot("trailer-name");
    }
}