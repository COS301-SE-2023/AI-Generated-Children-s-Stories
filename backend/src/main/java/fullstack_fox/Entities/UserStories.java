package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name="UserStories")
public class UserStories {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    public User getUser() {
        return user;
    }

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    // Story table relationship
    @JsonBackReference("story-userStories") //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    private Story story;

    public boolean getLiked() {
        return liked;
    }

    public void setLiked(boolean liked) {
        this.liked = liked;
    }

    @Column()
    private boolean liked;

    public int getPageNumber() {
        return pageNumber;
    }

    @Column()
    private int pageNumber;

    public UserStories (User user, Story story, boolean liked, int pageNumber){
        this.user = user;
        this.story = story;
        this.liked = liked;
        this.pageNumber = pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Story getStory() {
        return story;
    }
}
