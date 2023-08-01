package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;


@Entity
@Table(name="Progress")
public class Progress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    public Progress(){}

    @JsonBackReference("user-progress")
    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "storyId")
    @JsonBackReference("story-progress")
    private Story story;

    public Long getId() {
        return id;
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public User getUser() {
        return user;
    }

    public Story getStory() {
        return story;
    }

    @Column()
    private int pageNumber;

    public Progress(User user, Story story, int pageNumber) {
        this.user = user;
        this.story = story;
        this.pageNumber = pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }


}
