package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class StoryPageController extends BaseController{

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
    private void switchToPreview() throws IOException {
        PagePreviewController pagePreviewController = new PagePreviewController();
        try {
            App.setRoot("page-preview",pagePreviewController);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}