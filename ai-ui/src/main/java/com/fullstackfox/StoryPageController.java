package com.fullstackfox;

import java.io.IOException;



import javafx.fxml.FXML;

public class StoryPageController extends Processors{

    @FXML
    private void switchToHome() throws IOException {
        
            App.setRoot("home");
        
    }

    @FXML
    private void switchToPreview() throws IOException {
        
            App.setRoot("page-preview");
        
    }
}