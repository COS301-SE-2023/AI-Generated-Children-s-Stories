package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class TrailerNameController extends Processors{

    @FXML
    private void switchToHome() throws IOException {
        
            App.setRoot("home");
        
    }

    @FXML
    private void switchToPage() throws IOException {
        
            App.setRoot("story-page");
       
    }
}