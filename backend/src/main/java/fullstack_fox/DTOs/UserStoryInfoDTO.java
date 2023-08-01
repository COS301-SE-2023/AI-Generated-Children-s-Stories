package fullstack_fox.DTOs;

import javax.persistence.*;

@Entity
@Table(name = "user_story_info")
public class UserStoryInfoDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long userId;
    private Long storyId;
    private String title;
    private String trailer;
    private boolean liked;
    private int pageNo;
    private int totalPages;

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public Long getStoryId() {
        return storyId;
    }

    public String getTitle() {
        return title;
    }

    public String getTrailer() {
        return trailer;
    }

    public boolean isLiked() {
        return liked;
    }

    public int getPageNo() {
        return pageNo;
    }

    public int getTotalPages() {
        return totalPages;
    }
}
