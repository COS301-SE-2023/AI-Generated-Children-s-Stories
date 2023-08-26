package Controllers;

import java.io.IOException;

import com.fullstackfox.App;
import com.fullstackfox.BaseController;

import javafx.fxml.FXML;

public class CharacterController extends BaseController {

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
    private void switchToTrailer() throws IOException {
        TrailerImageController trailerImageController = new TrailerImageController();
        try {
            App.setRoot("trailer-image",trailerImageController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}