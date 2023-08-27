package Controllers;

import java.io.IOException;

import com.fullstackfox.App;
import com.fullstackfox.BaseController;

import javafx.fxml.FXML;

public class TrailerImageController extends Processors{

    @FXML
    private void switchToHome() throws IOException {
       
            App.setRoot("home");
        
    }

    @FXML
    private void switchToName() throws IOException {
        
            App.setRoot("trailer-name");
      
    }
}