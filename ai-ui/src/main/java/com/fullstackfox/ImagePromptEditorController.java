package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

import javafx.scene.control.*;


public class ImagePromptEditorController {
    
    //private Button generationButton;
    @FXML
    private TextArea storyPrompt;
    @FXML
    private TextField age;
    @FXML
    private Slider lenSlider;
    @FXML
    private TextArea storyOut;

    @FXML
    private void switchToHome() throws IOException {
        
            App.setRoot("home");
       
    }
    

        @FXML
    private void getPrompt() throws IOException{

    }



}