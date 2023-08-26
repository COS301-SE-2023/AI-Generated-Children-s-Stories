package com.fullstackfox;

import java.net.URISyntaxException;
import java.util.ArrayList;

//import javafx.fxml.FXML;

public abstract class BaseController {
    protected JsonProcessor jProcessor;
    protected APICalls api;
    protected StoryGeneration storyGen;
    protected App appInstance;  // Add this field

      

    public BaseController() {
        jProcessor = new JsonProcessor();
        api = null; // Initialize as needed
        storyGen = null; // Initialize as needed
    }
    
 public void setAppInstance(App appInstance) {  // Add this method
        this.appInstance = appInstance;
    }

        public void createProcessors() throws URISyntaxException {
        ArrayList<String> configList = jProcessor.readJson("config.json");
        api = new APICalls(configList);
        System.out.println(configList.get(7));
        storyGen = new StoryGeneration(api, configList.get(7));
    }

    public APICalls getAPICalls() {
        return api;
    }

    public StoryGeneration getStoryGenerator() {
        return storyGen;
    }

    // public void setProcessors() {
    //     // Initialize the processors components here
    //     ArrayList<String> configList = jProcessor.readJson("config.json");
    //     api = new APICalls(configList);
    //     storyGen = new StoryGeneration(api, configList.get(7));
    // }
}