package Controllers;

import java.io.IOException;

import com.fullstackfox.App;

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
        HomeController homeController = new HomeController();
        try {
            App.setRoot("home",homeController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    

        @FXML
    private void getPrompt() throws IOException{

    }



}