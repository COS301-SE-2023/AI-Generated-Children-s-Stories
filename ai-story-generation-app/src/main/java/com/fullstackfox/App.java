package com.fullstackfox;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URISyntaxException;

/**
 * JavaFX App
 */

//To make jar
//        1. mvn clean package -DskipTests
//        2. cd target
//        2. java -jar .\target\backend-1.0-SNAPSHOT.jar

public class App extends Application {
    private static Scene scene;
    @Override
    public void start(Stage stage) throws IOException, URISyntaxException {
        scene = new Scene(loadFXML("home"), 1040, 585);
        stage.setResizable(false);
        stage.setTitle("Artificial Intellignece Story Generator");
        Image iconImage = new Image(getClass().getResourceAsStream("Icon.png"));
        stage.getIcons().add(iconImage);
        stage.setScene(scene);
        stage.show();
        Story.getInstance();
        StoryGeneration.getInstance();
    }

    static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void main(String[] args) {
        launch(args);
    }
}