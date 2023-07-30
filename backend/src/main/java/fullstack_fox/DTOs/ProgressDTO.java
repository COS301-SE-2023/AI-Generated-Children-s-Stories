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
        this.story = new StoryDTO();
        this.story.setPages(story.getPages());
        this.story.setTitle(story.getTitle());
        this.story.setTrailer(story.getTrailer());
    }

    private StoryDTO story;

    public Long getUser() {
        return user;
    }

    public StoryDTO getStory() {
        return story;
    }

    private Long user;

    public ProgressDTO() {
    }
}
