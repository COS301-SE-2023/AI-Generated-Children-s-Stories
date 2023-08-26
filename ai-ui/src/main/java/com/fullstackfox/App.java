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
public class App extends Application {

    private static Scene scene;

    @Override
    public void start(Stage stage) throws IOException {
      // Processors processes = new Processors();
       //HomeController homeController = new HomeController();
        scene = new Scene(loadFXML("home"), 1040, 585);
        stage.setResizable(false);
        stage.setTitle("Artificial Intellignece Story Generator");
        Image iconImage = new Image(getClass().getResourceAsStream("/com/fullstackfox/resources/Icon.png"));
        stage.getIcons().add(iconImage);
        stage.setScene(scene);
        stage.show();
    }


    static void setRoot(String fxml, BaseController controller) throws IOException {
        FXMLLoader loader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        loader.setController(controller); // Set the controller instance
        try {
            controller.createProcessors();
        } catch (URISyntaxException e) {

            e.printStackTrace();
        }
        Parent root = loader.load();
        scene.setRoot(root);
    }


    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void main(String[] args) {
        launch();
    }

}