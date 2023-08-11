package com.fullstackfox;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
//import org.json.*;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;

public class SettingsController {
    @FXML
    private TextField appID;
    @FXML
    private TextField channelID;
    @FXML
    private TextField guildID;
    @FXML
    private TextField sessionID;
    @FXML
    private TextField botAuth;
    @FXML
    private TextField userAuth;
    @FXML
    private TextField chatKey;
    @FXML
    private TextField midSeed;

    @FXML
    private void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    private void close() throws IOException {
        Platform.exit();
    }

    @FXML
    private void setAppID() throws IOException {
        if(appID.getText() != null && !appID.getText().isEmpty()){
  
    }
}
     @FXML
    private void setChannelID() throws IOException {
        
    }
     @FXML
    private void setGuildID() throws IOException {
        
    }
     @FXML
    private void setSessionID() throws IOException {
        
    }
     @FXML
    private void setBotAuth() throws IOException {
        
    }
 @FXML
    private void setUserAuth() throws IOException {
        
    }
     @FXML
    private void setChatKey() throws IOException {
        
    }
     @FXML
    private void setMidSeed() throws IOException {
        
    }



    // helper function

    // public void updateJson(String inFName, String keyToUpdate, String newValue) {
    //     try (InputStream inputStream = this.getClass().getResourceAsStream("resources/" + inFName)) {
    //         if (inputStream != null) {
    //             // Read the resource using BufferedReader or any other appropriate method
    //             try (BufferedReader reader = new BufferedReader(
    //                     new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
    //                 JSONTokener tokener = new JSONTokener(reader);
    //                 JSONObject jsonObject = new JSONObject(tokener);

    //                 // Update the specific key with the new value
    //                 jsonObject.put(keyToUpdate, newValue);

    //                 // Write the updated JSON back to the file
    //                 try (OutputStream outputStream = new FileOutputStream("resources/" + inFName)) {
    //                     outputStream.write(jsonObject.toString().getBytes(StandardCharsets.UTF_8));
    //                 }
    //             }
    //         } else {
    //             // The resource could not be found
    //             System.out.println("Resource not found: " + inFName);
    //         }
    //     } catch (IOException e) {
    //         // Handle any potential IO exceptions
    //         e.printStackTrace();
    //     }
    // }






}