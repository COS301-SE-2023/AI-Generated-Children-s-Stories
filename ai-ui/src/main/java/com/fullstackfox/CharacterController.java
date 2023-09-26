package com.fullstackfox;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

public class CharacterController {

    @FXML
    private TextArea story = new TextArea(StoryGeneration.getStory());
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
    private void customCharacter() throws IOException {
        regenButton.setDisable(true);
        String prpt = prompt.getText();

        if (!prpt.isEmpty()) {
            try {
                lst = StoryGeneration.characterImageCustom(prpt);
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
        regenButton.setDisable(false);
    }

    @FXML
    private void makeCharacter() throws IOException, URISyntaxException {
        this.disableTillUpscale();
        story.setText(StoryGeneration.getStory());

        lst = StoryGeneration.characterImage(StoryGeneration.getStory());
        String url = lst.get(0);
        Image imageU = new Image(url);
        ImageView imageView = new ImageView(imageU);
        imageView.setFitHeight(380);
        imageView.setFitWidth(380);
        image.getChildren().add(imageView);
        regenButton.setDisable(false);

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
    private void switchToTrailer() throws IOException {
        App.setRoot("trailer-image");
    }


    @FXML
    private void upscale1() throws IOException {
        try {
            String url = StoryGeneration.imageUpscale(lst, "1");
            StoryGeneration.setCharacter(url);
            Image imageU = new Image(url);
            ImageView imageView = new ImageView(imageU);
            imageView.setFitHeight(380);
            imageView.setFitWidth(380);
            image.getChildren().add(imageView);

            this.upscaleEnable();
        } catch (URISyntaxException e) {
            System.out.println("Error in Character Upscale Generation");
            e.printStackTrace();
        }


    }

    @FXML
    private void upscale2() throws IOException {
        try {
            String url = StoryGeneration.imageUpscale(lst, "2");
            StoryGeneration.setCharacter(url);
            Image imageU = new Image(url);
            ImageView imageView = new ImageView(imageU);
            imageView.setFitHeight(380);
            imageView.setFitWidth(380);
            image.getChildren().add(imageView);
            this.upscaleEnable();
        } catch (URISyntaxException e) {
            System.out.println("Error in Character Upscale Generation");
            e.printStackTrace();

        }
    }

    @FXML
    private void upscale3() throws IOException {

        try {
            String url = StoryGeneration.imageUpscale(lst, "3");
            StoryGeneration.setCharacter(url);
            Image imageU = new Image(url);
            ImageView imageView = new ImageView(imageU);
            imageView.setFitHeight(380);
            imageView.setFitWidth(380);
            image.getChildren().add(imageView);
            this.upscaleEnable();
        } catch (URISyntaxException e) {
            System.out.println("Error in Character Upscale Generation");
            e.printStackTrace();
        }
    }

    @FXML
    private void upscale4() throws IOException {
        try {
            String url = StoryGeneration.imageUpscale(lst, "4");
            StoryGeneration.setCharacter(url);
            Image imageU = new Image(url);
            ImageView imageView = new ImageView(imageU);
            imageView.setFitHeight(380);
            imageView.setFitWidth(380);
            image.getChildren().add(imageView);
            this.upscaleEnable();
        } catch (URISyntaxException e) {
            System.out.println("Error in Character Upscale Generation");
            e.printStackTrace();
        }
    }


}