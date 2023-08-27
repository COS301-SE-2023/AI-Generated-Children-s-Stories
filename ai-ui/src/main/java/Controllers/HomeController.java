package Controllers;

import java.io.IOException;
import java.net.URISyntaxException;

import com.fullstackfox.App;
import com.fullstackfox.BaseController;

import javafx.application.Platform;
import javafx.fxml.FXML;

public class HomeController extends Processors{

    @FXML
    private void switchToSettings() throws IOException {
       
            App.setRoot("settings");
        
    }

    @FXML
    private void close() throws IOException {
        Platform.exit();
    }

    @FXML
    private void switchToStory() throws IOException, URISyntaxException {
        Processors process = Processors.getInstance();
    
            process.createProcessors();
            App.setRoot("create-a-story");
        
    }
}

