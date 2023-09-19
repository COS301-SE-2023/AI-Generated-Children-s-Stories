package fullstack_fox.DTOs;

import fullstack_fox.Entities.Story;

public class PostStoryDTO {
    public Story getStory() {
        return story;
    }

    public void setStory(Story story) {
        this.story = story;
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    Story story;
    String apiKey;


}
