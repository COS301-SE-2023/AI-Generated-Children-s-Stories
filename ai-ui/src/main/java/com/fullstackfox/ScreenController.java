
package com.fullstackfox;

import java.io.IOException;
import javafx.fxml.FXML;

public class ScreenController {

    @FXML
    private void switchToPrimary() throws IOException {
        App.setRoot("primary");
    }
}