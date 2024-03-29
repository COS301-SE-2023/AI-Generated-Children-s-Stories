package com.fullstackfox;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.*;
import java.nio.charset.StandardCharsets;

public class SettingsController{
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
        if (appID.getText() != null && !appID.getText().isEmpty()) {
            updateJson("applicationID", appID.getText());
            appID.clear();
        }
    }

    @FXML
    private void setChannelID() throws IOException {
        if (channelID.getText() != null && !channelID.getText().isEmpty()) {
            updateJson("channelID", channelID.getText());
            channelID.clear();
        }
    }

    @FXML
    private void setGuildID() throws IOException {
        if (guildID.getText() != null && !guildID.getText().isEmpty()) {
            updateJson("guildID", guildID.getText());
            guildID.clear();       }
    }

    @FXML
    private void setSessionID() throws IOException {
        if (sessionID.getText() != null && !sessionID.getText().isEmpty()) {
            updateJson("sessionID", sessionID.getText());
            sessionID.clear();
        }
    }

    @FXML
    private void setBotAuth() throws IOException {
        if (botAuth.getText() != null && !botAuth.getText().isEmpty()) {
            updateJson("botAuthorization", "bot " + botAuth.getText());
            botAuth.clear();
        }
    }

    @FXML
    private void setUserAuth() throws IOException {
        if (userAuth.getText() != null && !userAuth.getText().isEmpty()) {
            updateJson("userAuthorization", userAuth.getText());
            userAuth.clear();       }
    }

    @FXML
    private void setChatKey() throws IOException {
        if (chatKey.getText() != null && !chatKey.getText().isEmpty()) {
            updateJson("chatGPTKey", chatKey.getText());
            chatKey.clear();
        }
    }

    @FXML
    private void setMidSeed() throws IOException {
        if (midSeed.getText() != null && !midSeed.getText().isEmpty()) {
            updateJson("apiKey", midSeed.getText());
            midSeed.clear();
        }
    }

    // helper function
    public void updateJson(String keyToUpdate, String newValue) {
        String resourcesPath = "config.json";

        try (InputStream inputStream = SettingsController.class.getResourceAsStream(resourcesPath)) {
            if (inputStream != null) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                    JSONTokener tokener = new JSONTokener(reader);
                    JSONObject jsonObject = new JSONObject(tokener);
                    // Update the specific key with the new value
                    jsonObject.put(keyToUpdate, newValue);

                    String resourceAbsolutePath = SettingsController.class.getResource(resourcesPath).getPath();

                    // Write the updated JSON back to the file
                    try (BufferedWriter writer = new BufferedWriter(new FileWriter(resourceAbsolutePath))) {
                        writer.write(jsonObject.toString());
                    } catch (IOException e) {
                        // Handle any potential IO exceptions
                        e.printStackTrace();
                    }
                }
            } else {
                // The resource could not be found
                System.out.println("Resource not found: config.json");
            }
        } catch (IOException e) {
            // Handle any potential IO exceptions
            e.printStackTrace();
        }
    }

}