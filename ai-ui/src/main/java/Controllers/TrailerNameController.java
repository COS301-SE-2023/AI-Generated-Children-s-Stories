package Controllers;

import java.io.IOException;

import com.fullstackfox.App;
import com.fullstackfox.BaseController;

import javafx.fxml.FXML;

public class TrailerNameController extends BaseController{

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
    private void switchToPage() throws IOException {
        StoryPageController storyPageController = new StoryPageController();
        try {
            App.setRoot("story-page",storyPageController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}