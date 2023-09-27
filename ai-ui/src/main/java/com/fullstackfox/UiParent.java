package com.fullstackfox;

import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

public class UiParent {

    @FXML
    private TextArea output_story;
    @FXML
    protected Pane output_image;
    @FXML
    protected TextArea input_custom_prompt;
    @FXML
    protected Button button_generate;
    @FXML
    protected Button button_accept;
    @FXML
    protected Button button_upscale_1;
    @FXML
    protected Button button_upscale_2;
    @FXML
    protected Button button_upscale_3;
    @FXML
    protected Button button_upscale_4;
    @FXML
    protected Button button_custom_generate;
    @FXML
    protected Button button_discard;

    protected ArrayList<String> list;
    public UiParent() {
        Platform.runLater(() -> {
            output_story.setText(StoryGeneration.getStory());
        });
    }

    @FXML
    protected void switchToHome() throws IOException {
        App.setRoot("home");
    }

    @FXML
    protected void disableTillUpscale() {
        button_accept.setDisable(true);
        button_upscale_1.setDisable(false);
        button_upscale_2.setDisable(false);
        button_upscale_3.setDisable(false);
        button_upscale_4.setDisable(false);
    }

    @FXML
    protected void upscaleAll(String toUpscale) throws IOException, URISyntaxException {
        String url = StoryGeneration.imageUpscale(list, toUpscale);
        StoryGeneration.setCharacter(url);
        setImage(url);
        enableGeneration();
        button_accept.setDisable(false);
        disableUpscale();
    }

    @FXML
    void setImage(String inUrl) throws IOException {
        Image imageU = new Image(inUrl);
        ImageView imageView = new ImageView(imageU);
        imageView.setFitHeight(380);
        imageView.setFitWidth(380);
        output_image.getChildren().add(imageView);
        enableGeneration();
    }

    @FXML
    protected void disableGeneration() throws IOException {
        button_accept.setDisable(true);
        disableUpscale();
        button_discard.setDisable(true);
        button_generate.setDisable(true);
        button_custom_generate.setDisable(true);
    }

    @FXML
    protected void enableGeneration() throws IOException {
        button_discard.setDisable(false);
        button_custom_generate.setDisable(false);
        button_generate.setDisable(false);
        enableUpscale();
    }

    @FXML
    protected void disableUpscale() throws IOException {
        button_upscale_1.setDisable(true);
        button_upscale_2.setDisable(true);
        button_upscale_3.setDisable(true);
        button_upscale_4.setDisable(true);
    }

    @FXML
    protected void enableUpscale() throws IOException {
        button_upscale_1.setDisable(false);
        button_upscale_2.setDisable(false);
        button_upscale_3.setDisable(false);
        button_upscale_4.setDisable(false);
    }

    @FXML
    protected void upscale1() throws IOException, URISyntaxException {
        upscaleAll("1");
    }
    @FXML
    protected void upscale2() throws IOException, URISyntaxException {
        upscaleAll("2");
    }

    @FXML
    protected void upscale3() throws IOException, URISyntaxException {
        upscaleAll("3");
    }

    @FXML
    protected void upscale4() throws IOException, URISyntaxException {
        upscaleAll("4");
    }
}
