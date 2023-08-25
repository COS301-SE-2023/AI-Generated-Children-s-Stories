package fullstack_fox.DTOs;

import fullstack_fox.Entities.Progress;

public class PostProgressDTO {
    public PostProgressDTO(Progress progress) {
        this.userId = progress.getUser().getId();
        this.pageNumber = progress.getPageNumber();
        this.storyId = progress.getStory().getId();
    }

    public PostProgressDTO(Long userId, Long storyId, int pageNumber) {
        this.userId = userId;
        this.storyId = storyId;
        this.pageNumber = pageNumber;
    }

    public PostProgressDTO(){}

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Long getStoryId() {
        return storyId;
    }

    public void setStoryId(Long storyId) {
        this.storyId = storyId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    int pageNumber;
    Long storyId;
    Long userId;

}
