package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class SettingsController {

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }
}