package com.fullstackfox;

import java.net.URISyntaxException;
import java.util.List;
import java.util.ArrayList;
import org.json.*;

public class ImageGeneration {

    APICalls callApi;

    public ImageGeneration(APICalls inApiLibrary) throws URISyntaxException {
        callApi = inApiLibrary;
    }

    public ArrayList<String> generateImages(String inPrompt) {
        String lastMessageID = this.latestMessageID();
        callApi.postPrompt(inPrompt);
        this.imageGenDelay(lastMessageID);
        String message = callApi.getMessage();
        String imageURL = this.extractImageUrl(message);
        lastMessageID = this.latestMessageID();
        ArrayList<String> result = new ArrayList<>();
        result.add(imageURL);
        result.add(lastMessageID);
        return result;
    }

    public String upscaleImage(List<String> inImageDetails, String inUpscale) throws URISyntaxException {
        callApi.postUpscale(inImageDetails.get(0), inImageDetails.get(1), inUpscale);
        this.imageGenDelay(inImageDetails.get(1));
        String message = callApi.getMessage();
        String imageURL = this.extractImageUrl(message);
        return imageURL;
    }

    public void imageGenDelay(String lastMessageID) {
        boolean idCheck = true;
        boolean check = true;
        String message;
        String id;
        String url;
        while (idCheck) {
            id = this.latestMessageID();
            if (id.compareTo(lastMessageID) != 0) {
                idCheck = false;
                while (check) {
                    message = callApi.getMessage();
                    url = this.extractImageUrl(message);
                    if (url != null) {
                        this.urlUnitTest(url);
                        String fileType = url.substring(url.length() - 3);
                        if (fileType.compareTo("png") == 0) {
                            check = false;
                        }
                    }
                    if (check) {
                        try {
                            Thread.sleep(5000);
                        } catch (InterruptedException e) {

                            e.printStackTrace();
                        }
                    }
                }
            } else {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {

                    e.printStackTrace();
                }
            }
        }
    }

    // todo: test
    public String extractImageUrl(String inResponseBody) {

        JSONArray jsonArray = new JSONArray(inResponseBody);
        String content = "";
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject messageObject = jsonArray.getJSONObject(i);
            content = messageObject.getString("content");
        }
        if (content.contains("(Waiting to start)")) {
            return null;
        }
        String url = "";
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            url = jsonObject.getJSONArray("attachments")
                    .getJSONObject(0)
                    .getString("url");
        }
        return url;
    }

    private void urlUnitTest(String inUrl) {
        if (inUrl == "") {
            System.out.println("Message recived not an image");
        } else {
            String fileType = inUrl.substring(inUrl.length() - 3);
            if (fileType.compareTo("png") == 0) {
                System.out.println("Message recived is a complete image");
            } else {
                System.out.println("Message recived is not a complete image");
            }
        }
    }

    public String latestMessageID() {
        String message = callApi.getMessage();
        String id = this.extractMessageID(message);
        return id;
    }

    /// description: extracts the message id from the response body
    /// @param: inResponseBody: the response body from the api call
    /// @return: the message id
    public String extractMessageID(String inResponseBody) {
        JSONArray jsonArray = new JSONArray(inResponseBody);
        String id = "";
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject messageObject = jsonArray.getJSONObject(i);
            id = messageObject.getString("id");
        }
        return id;
    }
}
