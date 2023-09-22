package com.fullstackfox;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

public class StoryPageController{

         Processors process = Processors.getInstance();
        StoryGeneration gen = process.getStoryGeneration();
       // private int pages = gen.getPageNums();

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
        @FXML
        private Label paraNum;

        @FXML
    private TextArea storyOut;
 
    @FXML
    private Button editButton;

    @FXML
    private void switchToHome() throws IOException {
            App.setRoot("home");
        
    }

      @FXML
    private void generate() throws IOException {
        String prompt = gen.getPagePrompt(gen.getPageNums());
        ArrayList<String> page;
        try {
                page = gen.pageImage(prompt,gen.getChar());
                String url = page.get(0);
                Image imageU = new Image(url); 
                ImageView imageView = new ImageView(imageU);
                imageView.setFitHeight(380); 
                imageView.setFitWidth(380); 
                image.getChildren().add(imageView);
        regenButton.setDisable(false);
        } catch (URISyntaxException e) {

                e.printStackTrace();
        }

    }

    @FXML
    private void switchToPreview() throws IOException {
      //  if (gen.getPageNums()>0){
                gen.decPages();
                App.setRoot("story-page");
        //}else{
        if (gen.getPageNums()==0){
            App.setRoot("page-preview");
        }
    }
}