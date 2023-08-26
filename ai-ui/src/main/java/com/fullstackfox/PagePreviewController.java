package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class PagePreviewController extends BaseController{

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
    private void switchToName() throws IOException {
        TrailerNameController trailerNameController = new TrailerNameController();
        try {
            App.setRoot("trailer-name",trailerNameController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}