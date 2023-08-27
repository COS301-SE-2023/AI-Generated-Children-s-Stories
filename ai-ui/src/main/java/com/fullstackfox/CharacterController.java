package com.fullstackfox;

import java.io.IOException;



import javafx.fxml.FXML;

public class CharacterController {

    @FXML
    private void switchToHome() throws IOException {
        
            App.setRoot("home");
        
    }

    @FXML
    private void switchToTrailer() throws IOException {

            App.setRoot("trailer-image");
       
    }
}