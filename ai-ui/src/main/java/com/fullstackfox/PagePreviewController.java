package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class PagePreviewController {

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void switchToName() throws IOException {
        App.setRoot("page-preview");
    }
}