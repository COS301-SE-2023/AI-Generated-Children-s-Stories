package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;


@Entity
@Table(name="Progress")
public class Progress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    public Progress(){}

    @JsonIgnoreProperties("progress")
    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;


    @JsonIgnoreProperties("progress")
    @ManyToOne
    @JoinColumn(name = "storyId")
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
