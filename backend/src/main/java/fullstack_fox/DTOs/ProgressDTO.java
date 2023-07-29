package fullstack_fox.DTOs;

public class ProgressDTO {
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public void setUser(Long user) {
        this.user = user;
    }

    private Long id;
    private int pageNumber;

    public void setStory(Long story) {
        this.story = story;
    }

    private Long story;

    public Long getUser() {
        return user;
    }

    public Long getStory() {
        return story;
    }

    private Long user;

    public ProgressDTO() {
    }
}
