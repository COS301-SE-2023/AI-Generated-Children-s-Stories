//package com.fullstackfox;
//
//import java.net.URISyntaxException;
//import java.util.ArrayList;
//
//public class Processors {
//    int counter;
//    private JsonProcessor jProcessor;
//    private APICalls api;
//    private StoryGeneration storyGen;
//
//    public Processors() {
//        jProcessor = new JsonProcessor();
//        api = null; // Initialize as needed
//        storyGen = null; // Initialize as needed
//    }
//
//    public void createProcessors() throws URISyntaxException {
//        ArrayList<String> configList = jProcessor.readJson();
//        api = new APICalls(configList);
//        storyGen = new StoryGeneration(api, configList.get(7));
//    }
//
//    public APICalls getAPICalls() {
//        return api;
//    }
//
//    public StoryGeneration getStoryGeneration() {
//        return storyGen;
//    }
//}
