package com.fullstackfox;

import java.net.URISyntaxException;
import java.util.ArrayList;

public class Processors {
    int counter;
    private static Processors instance; // Singleton instance

    private JsonProcessor jProcessor;
    private APICalls api;
    private StoryGeneration storyGen;

    public Processors() {
        jProcessor = new JsonProcessor();
        api = null; // Initialize as needed
        storyGen = null; // Initialize as needed
    }

    public static Processors getInstance() {
        if (instance == null) {
            instance = new Processors();
        }
        return instance;
    }

    // Call when one presses create story
    public void createProcessors() throws URISyntaxException {
        ArrayList<String> configList = jProcessor.readJson("config.json");
        // for(String i : configList){
        //     System.out.println(i);
        // }
         api = new APICalls(configList);
         storyGen = new StoryGeneration(api, configList.get(7));
    }

    public APICalls getAPICalls() {
        return api;
    }

    public StoryGeneration getStoryGeneration() {
        return storyGen;
    }

    // public void increment(){
    // counter++;
    // System.out.println(counter);
    // }

    // 1. Processors process = Processors.getInstance();

    // 2. APICalls api = processor.getAPICalls();
    // 3. StoryGeneration storyGen = processor.getStoryGneration();

}
