package fullstack_fox.DTOs;

import fullstack_fox.Entities.Story;

public class ProgressDTO {

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public void setUser(Long user) {
        this.user = user;
    }

    private int pageNumber;

    public void setStory(Story story) {
        this.story = story;
    }

    private Story story;

    public Long getUser() {
        return user;
    }

    public Story getStory() {
        return story;
    }

    private Long user;

    public ProgressDTO() {
    }
}
