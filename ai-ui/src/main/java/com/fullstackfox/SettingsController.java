package com.fullstackfox;

import java.io.IOException;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.*;

public class SettingsController {

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void close() throws IOException {
        Platform.exit();
    }

     @FXML
    private void setAppID() throws IOException {
        
    }




}