package Controllers;

import java.io.IOException;

import com.fullstackfox.App;
import com.fullstackfox.BaseController;

import javafx.application.Platform;
import javafx.fxml.FXML;

public class HomeController extends BaseController{

    @FXML
    private void switchToSettings() throws IOException {
        SettingsController settingsController = new SettingsController();
        try {
            App.setRoot("settings", settingsController );
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    private void close() throws IOException {
        Platform.exit();
    }

    @FXML
    private void switchToStory() throws IOException {
        
        CreateAStoryController createAStoryController = new CreateAStoryController();
        try {
            App.setRoot("create-a-story",createAStoryController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

