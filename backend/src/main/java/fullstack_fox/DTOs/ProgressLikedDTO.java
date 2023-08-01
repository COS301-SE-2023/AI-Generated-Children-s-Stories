package fullstack_fox.DTOs;

import fullstack_fox.Entities.Story;

//Rules
//Not in progress: page = 0
//Not liked: like = false

public class ProgressLikedDTO {

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

    public boolean getLiked() {
        return isLiked;
    }

    public void setLiked(boolean liked) {
        isLiked = liked;
    }

    private boolean isLiked;

    public void setStory(Story story) {
        this.story = new StoryDTO();
        this.story.setPages(story.getPages());
        this.story.setTitle(story.getTitle());
        this.story.setTrailer(story.getTrailer());
        this.story.setId(story.getId());
    }

    private StoryDTO story;

    public Long getUser() {
        return user;
    }

    public StoryDTO getStory() {
        return story;
    }

    private Long user;

    public ProgressLikedDTO() {
    }
}
