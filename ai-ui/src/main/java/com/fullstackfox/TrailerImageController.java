package com.fullstackfox;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.fxml.FXML;
import javafx.scene.control.*;

public class TrailerImageController {
Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();

        @FXML
    private TextArea story;
 
      

    @FXML
    private Pane image;
    @FXML
    private TextArea prompt;
    @FXML
    private Button regenButton;

    @FXML
    private Button acceptButton;
    @FXML
    private Button button1;
    @FXML
    private Button button2;
    @FXML
    private Button button3;
    @FXML
    private Button button4;

    private ArrayList<String> lst;

    @FXML
    private void switchToHome() throws IOException {
         App.setRoot("home");
    }

    @FXML
    private void switchToName() throws IOException {
        
            App.setRoot("trailer-name");
      
    }

    @FXML
    private void customTrailer() throws IOException {
        regenButton.setDisable(true);
        String prpt = prompt.getText();

            if(!prpt.isEmpty()){
               try {
                lst = gen.storyTrailerImageCustom(gen.getChar(), prpt);
        } catch (URISyntaxException e) {
                System.out.println("fail");
                e.printStackTrace();
        }
        }
                String url = lst.get(0);
                Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
                this.disableTillUpscale();
    }


    @FXML
    private void makeTrailer() throws IOException, URISyntaxException {

        story.setText(gen.getStory());
                lst=gen.storyTrailerImage(gen.getStory(), gen.getChar());
                String url = lst.get(0);
                Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
        regenButton.setDisable(false);    
        this.disableTillUpscale();    
    }

    @FXML
    private void disable() throws IOException {

            regenButton.setDisable(true);

       
    }
    private void disableTillUpscale() throws IOException {
        acceptButton.setDisable(true);  
         button1.setDisable(false);  
        button2.setDisable(false);  
        button3.setDisable(false);  
        button4.setDisable(false); 
        
    }
    private void upscaleEnable() throws IOException {
        acceptButton.setDisable(false);  
        button1.setDisable(true);  
        button2.setDisable(true);  
        button3.setDisable(true);  
        button4.setDisable(true);  
    }


    @FXML
    private void upscale1() throws IOException {

       try {
        String url = gen.imageUpscale(lst ,"1");
        gen.setTrailer(url);
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(360); 
                imageView.setFitWidth(360); 
                image.getChildren().add(imageView);
                this.upscaleEnable();

        } catch (URISyntaxException e) {
        System.out.println("Error in Trailer Upscale Generation");
        e.printStackTrace();
}
            
       
    }
        @FXML
    private void upscale2() throws IOException {

       // Processors process = Processors.getInstance();
       // StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"2");
        gen.setTrailer(url);
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(360); 
                imageView.setFitWidth(360); 
                image.getChildren().add(imageView);
                this.upscaleEnable();
        } catch (URISyntaxException e) {
        System.out.println("Error in Trailer Upscale Generation");
        e.printStackTrace();
       
    }
}

        @FXML
    private void upscale3() throws IOException {

       // Processors process = Processors.getInstance();
      //  StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"3");
        gen.setTrailer(url);
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
                this.upscaleEnable();
        } catch (URISyntaxException e) {
        System.out.println("Error in Trailer Upscale Generation");
        e.printStackTrace();
        }
    }

        @FXML
    private void upscale4() throws IOException {

      //  Processors process = Processors.getInstance();
       // StoryGeneration gen = process.getStoryGeneration();

       try {
        String url = gen.imageUpscale(lst ,"4");
        gen.setTrailer(url);
         Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
                this.upscaleEnable();
        } catch (URISyntaxException e) {
        System.out.println("Error in Trailer Upscale Generation");
        e.printStackTrace();
        }  
    }



}