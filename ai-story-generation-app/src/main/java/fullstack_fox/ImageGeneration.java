package fullstack_fox;

import java.net.URISyntaxException;
import org.json.*;

public class ImageGeneration {

    APICalls callApi;

    public ImageGeneration(APICalls inApiLibrary) throws URISyntaxException {
        callApi = inApiLibrary;
    }

    public String generateImage(String inPromt) throws URISyntaxException {
        String lastMessageID = this.latestMessageID();
        callApi.postPrompt(inPromt);
        this.imageGenDelay(lastMessageID);
        String message = callApi.getMessage();
        String imageURL = this.extractImageUrl(message);
        lastMessageID = this.latestMessageID();
        callApi.postUpscale(imageURL, lastMessageID);
        this.imageGenDelay(lastMessageID);
        message = callApi.getMessage();
        imageURL = this.extractImageUrl(message);
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
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }

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