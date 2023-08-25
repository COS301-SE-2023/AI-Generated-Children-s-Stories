package fullstack_fox.DTOs;

import fullstack_fox.Entities.Page;

import java.util.List;

public class TrailerDTO {

    public TrailerDTO(String title, String trailer, Long storyId, boolean isLiked) {
        this.title = title;
        this.trailer = trailer;
        this.storyId = storyId;
        this.isLiked = isLiked;
    }

    String title;
    String trailer;
    Long storyId;

    boolean isLiked;

    public boolean isLiked() {
        return isLiked;
    }


    public String getTitle() {
        return title;
    }


    public String getTrailer() {
        return trailer;
    }


    public Long getStoryId() {
        return storyId;
    }

    public void setStoryId(Long storyId) {
        this.storyId = storyId;
    }

}
