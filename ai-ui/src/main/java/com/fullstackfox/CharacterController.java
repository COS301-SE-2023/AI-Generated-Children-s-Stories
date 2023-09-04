package com.fullstackfox;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.fxml.FXML;
import javafx.scene.control.*;

public class CharacterController {

        @FXML
    private TextArea story;
    @FXML
    private Pane image;
    @FXML
    private TextArea prompt;
    @FXML
    private Button regenButton;

    private ArrayList<String> lst;

    @FXML
    private void switchToHome() throws IOException {
         App.setRoot("home");
    }

    @FXML
    private void makeCharacter() throws IOException {
        regenButton.setDisable(true);
        Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();
       // ArrayList<String> lst = gen.characterImage(gen.story);
        story.setText(gen.story);
        try {
               lst = gen.characterImage(gen.story);
               String url = lst.get(0);
                Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
                } catch (URISyntaxException e) {
                System.out.println("Error in Character Generation");
                e.printStackTrace();
        }
        regenButton.setDisable(false);
        regenButton.setText("Regenerate Image");
           // App.setRoot("home");
        
    }

    @FXML
    private void switchToTrailer() throws IOException {

            App.setRoot("trailer-image");
       
    }


    @FXML
    private void upscale1() throws IOException {
        Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"1");
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);

        } catch (URISyntaxException e) {
        System.out.println("Error in Character Upscale Generation");
        e.printStackTrace();
}
            
       
    }
        @FXML
    private void upscale2() throws IOException {

        Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"2");
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);

        } catch (URISyntaxException e) {
        System.out.println("Error in Character Upscale Generation");
        e.printStackTrace();
       
    }
}

        @FXML
    private void upscale3() throws IOException {

        Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"3");
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);

        } catch (URISyntaxException e) {
        System.out.println("Error in Character Upscale Generation");
        e.printStackTrace();
        }
    }

        @FXML
    private void upscale4() throws IOException {

        Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"4");
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);

        } catch (URISyntaxException e) {
        System.out.println("Error in Character Upscale Generation");
        e.printStackTrace();
        }  
    }



}