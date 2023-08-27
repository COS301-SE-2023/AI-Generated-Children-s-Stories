package com.fullstackfox;

import java.net.URISyntaxException;
import okhttp3.*;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

public class APICalls {
    ArrayList<String> configList;

    public APICalls(ArrayList<String> inConfigList) throws URISyntaxException {
        configList = inConfigList;
    }

    public String getMessage() {
        OkHttpClient client = new OkHttpClient().newBuilder()
                .build();
        Request request = new Request.Builder()
                .url("https://discord.com/api/channels/1109207920551416000/messages?limit=1")
                .addHeader("Authorization",
                        configList.get(4))
                .addHeader("Cookie",
                        "__cfruid=020ecd137874e8ff8d41445a227de31a5f7514a1-1684622860; __dcfduid=cf25ec72f67f11ed8a888ae0f6e8a104; __sdcfduid=cf25ec72f67f11ed8a888ae0f6e8a1042802fad61c3954aaa0b380cf92aef35c55c1f038d1af006b63fe07261d5f75f0")
                .build();
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new Exception("Unexpected response code: " + response);
            }
            return response.body().string();
        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }

    public String postPrompt(String inPrompt) {
        OkHttpClient client = new OkHttpClient().newBuilder()
                .build();
        MediaType mediaType = MediaType.parse("application/json");
        String requestBodyStr = "{\r\n    \"type\": 2,\r\n    \"application_id\": \"" + configList.get(0)
                + "\",\r\n    \"guild_id\": \"" + configList.get(2)
                + "\",\r\n    \"channel_id\": \""
                + configList.get(1) + "\",\r\n    \"session_id\": \""
                + configList.get(3)
                + "\",\r\n    \"data\": {\r\n        \"id\": \"938956540159881230\",\r\n        \"version\": \"1118961510123847772\",\r\n        \"name\": \"imagine\",\r\n        \"type\": 1,\r\n        \"options\": [\r\n            {\r\n                \"type\": 3,\r\n                \"name\": \"prompt\",\r\n                \"value\": \""
                + inPrompt + "\"\r\n            }\r\n        ]\r\n    }\r\n}";

        RequestBody body = RequestBody.create(requestBodyStr, mediaType);
        Request request = new Request.Builder()
                .url("https://discord.com/api/v9/interactions")
                .method("POST", body)
                .addHeader("Authorization",
                        configList.get(5))
                .addHeader("Content-Type", "application/json")
                .addHeader("Cookie",
                        "__dcfduid=cf25ec72f67f11ed8a888ae0f6e8a104; __sdcfduid=cf25ec72f67f11ed8a888ae0f6e8a1042802fad61c3954aaa0b380cf92aef35c55c1f038d1af006b63fe07261d5f75f0")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new Exception("Unexpected response code: " + response);
            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return requestBodyStr;
    }

    public void postUpscale(String inImageURL, String inMessageID, String inUpscale) {
        OkHttpClient client = new OkHttpClient().newBuilder()
                .build();
        MediaType mediaType = MediaType.parse("application/json");
        int lastUnderscoreIndex = inImageURL.lastIndexOf("_");
        int lastDotIndex = inImageURL.lastIndexOf(".");

        String imageID = inImageURL.substring(lastUnderscoreIndex + 1, lastDotIndex);
        RequestBody body = RequestBody.create(
                "{\r\n    \"type\": 3,\r\n    \"application_id\": \"" + configList.get(0)
                        + "\",\r\n    \"guild_id\": \"" + configList.get(2)
                        + "\",\r\n    \"channel_id\": \"" + configList.get(1)
                        + "\",\r\n    \"message_flags\": 0,\r\n    \"session_id\": \""
                        + configList.get(3)
                        + "\",\r\n    \"message_id\": \"" + inMessageID
                        + "\",\r\n    \"data\": {\r\n       \"component_type\": 2,\r\n       \"custom_id\": \"MJ::JOB::upsample::"
                        + inUpscale + "::"
                        + imageID
                        + "\"\r\n    }\r\n}",
                mediaType);
        Request request = new Request.Builder()
                .url("https://discord.com/api/v9/interactions")
                .method("POST", body)
                .addHeader("Authorization", configList.get(5))
                .addHeader("Content-Type", "application/json")
                .addHeader("Cookie",
                        "__dcfduid=cf25ec72f67f11ed8a888ae0f6e8a104; __sdcfduid=cf25ec72f67f11ed8a888ae0f6e8a1042802fad61c3954aaa0b380cf92aef35c55c1f038d1af006b63fe07261d5f75f0")
                .build();
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new Exception("Unexpected response code: " + response);
            }
            System.out.println(response.body().string());
        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    public String promptGPT(String inPrompt) {
        String API_URL = "https://api.openai.com/v1/chat/completions";
        OkHttpClient client = new OkHttpClient.Builder()
                .connectTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(
                "{\"model\": \"gpt-3.5-turbo\", \"messages\":[{\"role\":\"user\",\"content\":\"" + inPrompt + "\"}]}",
                mediaType);
        Request request = new Request.Builder()
                .url(API_URL)
                .post(body)
                .addHeader("Authorization", "Bearer " + configList.get(6))
                .build();
        
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                System.out.println(response.body().string());
                throw new Exception("Unexpected response code: " + response);
            }
            return response.body().string();
        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }
}
